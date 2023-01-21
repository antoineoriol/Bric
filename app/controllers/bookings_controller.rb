class BookingsController < ApplicationController
  before_action :set_product, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.product = @product
    @booking.save
    redirect_to bookings_path
  end

  def index
    @bookings = Booking.all
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
