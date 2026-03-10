class UserPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  enum status: { growing: 0, archived: 1 }

  validates :status, presence: true
  validates :accumulated_points, numericality: { greater_than_or_equal_to: 0 }
  validates :selected_at, presence: true
end