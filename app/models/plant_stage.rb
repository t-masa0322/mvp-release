class PlantStage < ApplicationRecord
  belongs_to :plant

  validates :name, presence: true
  validates :stage_order, presence: true, uniqueness: { scope: :plant_id }
  validates :required_points, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
