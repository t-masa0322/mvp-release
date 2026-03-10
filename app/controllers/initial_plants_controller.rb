class InitialPlantsController < ApplicationController
  before_action :require_login

  def index
    @plants = Plant.includes(:plant_stages).all
  end

  def create
    plant = Plant.find(params[:plant_id])

    current_user.user_plants.where(status: :growing).update_all(
      status: UserPlant.statuses[:archived],
      archived_at: Time.current,
      updated_at: Time.current
    )

    current_user.user_plants.create!(
      plant: plant,
      selected_at: Time.current,
      status: :growing,
      accumulated_points: 0
    )

    redirect_to home_path, notice: "#{plant.name} を育て始めました"
  end
end
