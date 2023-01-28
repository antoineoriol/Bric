class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user

  has_many :bookings, dependent: :destroy

  has_one_attached :photo
  has_many :reviews, through: :bookings

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :capacity, presence: true
  validates :price, presence: true


  def status?
    status
  end

  include PgSearch::Model
  pg_search_scope :search_by_city_and_address,
    against: [ :city, :address ],
    using: {
      tsearch: { prefix: true }
    }

  def average_rating
    if self.bookings.empty?
      return {
        average: 0,
        num: 0
      }
    else
      ratings = []
      number = 0
      self.bookings.each do |booking|
        if booking.review
          number += 1
          ratings << booking.review.rating
        else
          next
        end
      end
      if ratings.empty?
        return {
          average: 0,
          num: 0
        }
      else
        return {
          average: ((ratings.sum) / ratings.count),
          num: number
        }
      end
    end
  end

  def reviews
    reviews = []
    unless self.bookings.empty?
      self.bookings.each do |booking|
        reviews << booking.review if booking.review
      end
    end
    return reviews
  end
end
