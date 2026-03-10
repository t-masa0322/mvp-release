class User < ApplicationRecord
  has_many :user_plants, dependent: :destroy
  has_many :plants, through: :user_plants

  validates :name, presence: true, uniqueness: true,
            format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字で入力してください" }
  validates :display_name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :total_growth_points, numericality: { greater_than_or_equal_to: 0 }
end
