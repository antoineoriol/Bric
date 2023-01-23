class BookingsController < ApplicationController
  before_action :set_product, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.product = @product
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
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
