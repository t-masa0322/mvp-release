class ExerciseLogsController < ApplicationController
  before_action :require_login
  before_action :set_exercise_log, only: %i[edit update destroy]

  def index
    @target_date =
      if params[:month].present?
        Date.strptime(params[:month], "%Y-%m")
      else
        Date.current
      end

    @calendar_start = @target_date.beginning_of_month.beginning_of_week(:sunday)
    @calendar_end   = @target_date.end_of_month.end_of_week(:sunday)

    @exercise_dates = current_user.exercise_logs
                                  .where(exercised_on: @calendar_start..@calendar_end)
                                  .pluck(:exercised_on)
                                  .uniq
  end

  def day
    @date = Date.parse(params[:date])
    @exercise_logs = current_user.exercise_logs
                                .where(exercised_on: @date)
                                .order(created_at: :desc)
  end

  def new
    @exercise_log = ExerciseLog.new(exercised_on: Date.current)
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

    redirect_to complete_exercise_logs_path(points: @exercise_log.earned_points), notice: "運動を記録しました"
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = @exercise_log.errors.full_messages.join(", ")
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    old_points = @exercise_log.earned_points
    old_user_plant = @exercise_log.user_plant

    new_points = ExerciseLog.calculate_points(
      exercise_log_params[:exercise_type],
      exercise_log_params[:duration_minutes]
    )

    ActiveRecord::Base.transaction do
      current_user.decrement!(:total_growth_points, old_points)
      old_user_plant&.decrement!(:accumulated_points, old_points)

      @exercise_log.update!(
        exercise_log_params.merge(earned_points: new_points)
      )

      current_user.increment!(:total_growth_points, new_points)
      @exercise_log.user_plant&.increment!(:accumulated_points, new_points)
    end

    redirect_to by_date_exercise_logs_path(date: @exercise_log.exercised_on), notice: "運動記録を更新しました"
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = @exercise_log.errors.full_messages.join(", ")
    render :edit, status: :unprocessable_entity
  end

  def destroy
    date = @exercise_log.exercised_on
    points = @exercise_log.earned_points
    user_plant = @exercise_log.user_plant

    ActiveRecord::Base.transaction do
      current_user.decrement!(:total_growth_points, points)
      user_plant&.decrement!(:accumulated_points, points)
      @exercise_log.destroy!
    end

    redirect_to by_date_exercise_logs_path(date: date), notice: "運動記録を削除しました"
  end

  def complete
    @earned_points = params[:points].to_i
    @current_user_plant = current_user.user_plants.includes(plant: :plant_stages).find_by(status: :growing)
  end

  private

  def set_exercise_log
    @exercise_log = current_user.exercise_logs.find(params[:id])
  end

  def exercise_log_params
    params.require(:exercise_log).permit(:exercise_type, :duration_minutes, :memo, :exercised_on)
  end
end
