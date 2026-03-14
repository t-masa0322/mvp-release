class Plant < ApplicationRecord
  has_many :plant_stages, -> { order(:stage_order) }, dependent: :destroy
  has_many :user_plants
  has_many :users, through: :user_plants

  validates :name, presence: true

  def image_file_name
    case name
    when "ひまわり"
      "plants/sunflower.jpeg"
    when "サボテン"
      "plants/cactus.jpeg"
    when "チューリップ"
      "plants/tulip.jpeg"
    end
  end

  def image_exists?
    return false if image_file_name.blank?

    File.exist?(Rails.root.join("app/assets/images", image_file_name))
  end
end
