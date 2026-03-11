class ExerciseLogsController < ApplicationController
  before_action :require_login

  def index
    @exercise_logs = current_user.exercise_logs.order(created_at: :desc)
  end

  def new
    @exercise_log = ExerciseLog.new
  end

  def create
    current_user_plant = current_user.user_plants.growing.first

    @exercise_log = current_user.exercise_logs.new(exercise_log_params)
    @exercise_log.user_plant = current_user_plant
    @exercise_log.earned_points = ExerciseLog.calculate_points(
      @exercise_log.exercise_type,
      @exercise_log.duration_minutes
    )

    ActiveRecord::Base.transaction do
      @exercise_log.save!

      current_user.increment!(:total_growth_points, @exercise_log.earned_points)
      current_user_plant&.increment!(:accumulated_points, @exercise_log.earned_points)
    end

    redirect_to complete_exercise_log_path(points: @exercise_log.earned_points), notice: "運動を記録しました"
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = @exercise_log.errors.full_messages.join(", ")
    render :new, status: :unprocessable_entity
  end

  def complete
    @earned_points = params[:points].to_i
    @current_user_plant = current_user.user_plants.includes(plant: :plant_stages).find_by(status: :growing)
  end

  private

  def exercise_log_params
    params.require(:exercise_log).permit(:exercise_type, :duration_minutes, :memo)
  end
end
