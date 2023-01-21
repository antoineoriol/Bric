class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    booking = Booking.create(product_id: params[:id], user_id: current_user, start_date: params[:start_date], end_date: params[:end_date])
    booking.user = current_user
    redirect_to bookings_path
  end

  def index
    @bookings = Booking.all
  end
end
