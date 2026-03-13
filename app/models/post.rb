class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :body, presence: true, length: { maximum: 500 }
end
