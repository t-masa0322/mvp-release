class HomesController < ApplicationController
  before_action :require_login

  def show
    @current_user_plant = current_user.user_plants
                                      .includes(plant: :plant_stages)
                                      .find_by(status: :growing)

    @today_exercise_logs = current_user.exercise_logs
                                      .where(exercised_on: Date.current)
                                      .order(created_at: :asc)

    @today_earned_points = @today_exercise_logs.sum(:earned_points)
  end
end
