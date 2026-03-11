class UserPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  enum status: { growing: 0, archived: 1 }

  validates :status, presence: true
  validates :accumulated_points, numericality: { greater_than_or_equal_to: 0 }
  validates :selected_at, presence: true

  def current_stage
    plant.plant_stages
        .where("required_points <= ?", accumulated_points)
        .order(required_points: :desc)
        .first
  end

  def next_stage
    plant.plant_stages
        .where("required_points > ?", accumulated_points)
        .order(required_points: :asc)
        .first
  end

  def points_to_next_stage
    return 0 unless next_stage

    next_stage.required_points - accumulated_points
  end
end
