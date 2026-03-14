class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :user_plant, optional: true

  enum exercise_type: {
    walk: 0,
    strength_training: 1,
    stretching: 2,
    running: 3,
    yoga: 4
  }

  validates :exercise_type, presence: true
  validates :duration_minutes, presence: true, numericality: { greater_than: 0 }
  validates :earned_points, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :exercised_on, presence: true

  EXERCISE_POINT_RATES = {
    "walk" => 3,
    "strength_training" => 6,
    "stretching" => 2,
    "running" => 8,
    "yoga" => 4
  }.freeze

  def self.calculate_points(exercise_type, duration_minutes)
    rate = EXERCISE_POINT_RATES[exercise_type]
    return 0 unless rate

    rate * duration_minutes.to_i
  end
end
