class HomesController < ApplicationController
  before_action :require_login

  def show
    @current_user_plant = current_user.user_plants.includes(plant: :plant_stages).find_by(status: :growing)
  end
end
