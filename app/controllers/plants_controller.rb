class PlantsController < ApplicationController
  before_action :require_login

  def index
    @current_user_plant = current_user.user_plants.find_by(status: :growing)

    archived_user_plants = current_user.user_plants
                                      .archived
                                      .includes(:plant)
                                      .order(archived_at: :desc, updated_at: :desc)

    @archived_user_plants = archived_user_plants.uniq { |user_plant| user_plant.plant_id }

    if @current_user_plant.present?
      @archived_user_plants = @archived_user_plants.reject do |user_plant|
        user_plant.plant_id == @current_user_plant.plant_id
      end
    end

    archived_plant_ids = @archived_user_plants.map(&:plant_id)
    current_growing_plant_id = @current_user_plant&.plant_id

    excluded_ids = archived_plant_ids.dup
    excluded_ids << current_growing_plant_id if current_growing_plant_id.present?

    @available_plants = Plant.where.not(id: excluded_ids)
  end

  def select
    plant = Plant.find(params[:id])

    ActiveRecord::Base.transaction do
      current_user.user_plants.growing.update_all(
        status: UserPlant.statuses[:archived],
        archived_at: Time.current,
        updated_at: Time.current
      )

      current_user.user_plants.create!(
        plant: plant,
        status: :growing,
        accumulated_points: 0,
        selected_at: Time.current
      )
    end

    redirect_to home_path, notice: "#{plant.name} に変更しました"
  end
end
