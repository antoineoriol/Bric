class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true, uniqueness: true
end
