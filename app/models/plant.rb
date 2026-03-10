class Plant < ApplicationRecord
  has_many :plant_stages, -> { order(:stage_order) }, dependent: :destroy
  has_many :user_plants
  has_many :users, through: :user_plants

  validates :name, presence: true
end
