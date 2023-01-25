class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_one :review, dependent: :destroy

  validates :total_price, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
end
