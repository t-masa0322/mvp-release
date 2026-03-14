class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show select]
  before_action :require_login, only: %i[index show select]

  def index
    @plants = Plant.includes(:plant_stages).order(:id)
  end

  def show
  end

  def select
    current_user.user_plants.growing.update_all(status: :archived, archived_at: Time.current)

    user_plant = current_user.user_plants.find_or_initialize_by(plant: @plant)
    user_plant.status = :growing
    user_plant.selected_at = Time.current
    user_plant.archived_at = nil
    user_plant.save!

    redirect_to home_path, notice: "#{@plant.name}を育てる植物に設定しました"
  end

  private

  def set_plant
    @plant = Plant.includes(:plant_stages).find(params[:id])
  end
end
