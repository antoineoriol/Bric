class Product < ApplicationRecord
  belongs_to :user
  belongs_to :list
  has_one_attached :photo

  validates :title, presence: true, uniqueness: true
end
