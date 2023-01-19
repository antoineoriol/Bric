class List < ApplicationRecord
  has_many :reviews
  has_many :products
  has_one_attached :photo

  validates :name, uniqueness: true, presence: true
end
