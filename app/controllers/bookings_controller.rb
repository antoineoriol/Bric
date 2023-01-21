class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    booking = Booking.create!(product_id: params[:id], user_id: current_user)
    booking.user = current_user
    redirect_to bookings_path
  end

  def index
    @bookings = Booking.all
  end
end
