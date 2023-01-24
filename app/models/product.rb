class Product < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user

  has_many :bookings

  has_one_attached :photo
  has_many :reviews, through: :bookings

  validates :title, presence: true, uniqueness: true

end
