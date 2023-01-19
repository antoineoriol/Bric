class Review < ApplicationRecord
  belongs_to :list
  belongs_to :product
  validates :rating, :comment, presence: true
end
