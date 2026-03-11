class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :profile_image

  has_many :user_plants, dependent: :destroy
  has_many :plants, through: :user_plants

  attr_accessor :password, :password_confirmation

  validates :email, presence: true, uniqueness: true

  validates :name, presence: true, uniqueness: true,
            format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字で入力してください" },
            if: :profile_registration_step?

  validates :display_name, presence: true, length: { maximum: 20 }, if: :profile_registration_step?

  validates :password, length: { minimum: 6 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :total_growth_points, numericality: { greater_than_or_equal_to: 0 }

  def profile_registration_step?
    name.present? || display_name.present? || password.present? || password_confirmation.present?
  end

  def password_required?
    password.present? || password_confirmation.present?
  end
end
