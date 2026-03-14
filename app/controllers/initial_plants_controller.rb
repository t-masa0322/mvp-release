class InitialPlantsController < ApplicationController
  before_action :require_login
  before_action :ensure_initial_plant_selection

  def index
    @plants = Plant.includes(:plant_stages).with_attached_image.order(:id)
  end

  def create
    plant = Plant.find(params[:plant_id])

    current_user.user_plants.growing.update_all(status: :archived, archived_at: Time.current)

    user_plant = current_user.user_plants.find_or_initialize_by(plant: plant)
    user_plant.status = :growing
    user_plant.selected_at = Time.current
    user_plant.archived_at = nil
    user_plant.save!

    session.delete(:initial_plant_selection)

    redirect_to home_path, notice: "#{plant.name}を選択しました"
  end

  private

  def ensure_initial_plant_selection
    redirect_to home_path unless session[:initial_plant_selection]
  end
end
