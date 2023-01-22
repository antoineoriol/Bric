class BookingsController < ApplicationController
  before_action :find_user
  before_action :find_booking, only: [ :show, :edit, :update, :destroy ]
  before_action :find_product, only: [ :new, :create ]

  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def show
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = @user.id
    @booking.product_id = @product.id
    @booking.total_price = ((@booking.last_day - @booking.first_day).to_i) * @product.price
    authorize @booking
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
    authorize @booking
  end

  def update
    new_id = @booking.roduct_id
    @product = Product.find(new_id)
    @booking.update(booking_params)
    @booking.total_price = ((@booking.last_day - @booking.first_day).to_i) * @product.price
    authorize @booking
    if @booking.save
      redirect_to booking_path(@product, @booking)
    else
      render :edit
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end


  private

  def booking_params
    params.require(:booking).permit(:first_day, :last_day)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_user
    @user = current_user
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  # def total_price
  #   @product.price * @booking.date_booked.length
  # end
end
