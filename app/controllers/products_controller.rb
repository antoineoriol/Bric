class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_user, :database_search
  before_action :set_product, only: %i[show edit update destroy reviews]

  def index
    #@products = Product.all
    @products = policy_scope(Product)
    @markers = @products.geocoded.map do |product|
      {
        lng: product.longitude,
        lat: product.latitude,
        info_window_html: render_to_string(partial: "info_window", locals: {product: product}),
        marker_html: render_to_string(partial: "marker", locals: {product: product})
      }
    end
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = @user.id
    @product = current_user.products.build(product_params)
    authorize @product
    if @product.save
     flash[:notice] = "Product successfully listed for sale!"
     redirect_to @product
    else
     flash[:alert] = "Failed to list product for sale. Please try again."
     render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @booking = Booking.new
    @bookings = @product.bookings.where(status: "pending")
  end

  def edit
    Product.find(params[:id])
    authorize @product
  end

  def update
    @product.update(product_params)
    @booking = @product.bookings.find(params[:booking_id])
    if params[:status] == false
      @booking.update(status: "accepted")
      flash[:notice] = "Booking request accepted!"
    elsif params[:status] == false
      @booking.update(status: "rejected")
      flash[:notice] = "Booking request rejected!"
    else
      flash[:alert] = "Invalid status. Please try again."
    end
    redirect_to @product
  end

  def destroy
    @product.destroy
    redirect_to my_products_path
    authorize @products
  end

  def my_products
    @products = current_user.products
    @bookings = @products.map {|p| p.bookings}.flatten
    authorize @products
  end

  def search
    if params[:query].present?
      @products = Product.search_by_city_address(params[:query])
    else
      @products = Product.all
    end
    @count = @products.count
    @query = params[:query]

    @markers = @products.geocoded.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
        info_window: render_to_string(partial: "info_window", locals: { product: product }),
        marker_html: render_to_string(partial: "marker", locals: {product: product})
      }
    end
    authorize @products
    authorize @markers
  end

  def reviews
    unless @product.reviews.empty?
      @reviews = @product.reviews
    end
  end

  def status
    @products = Product.where(status: params[:status])
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
  end

  def my_bookings_as_owner
    @bookings = Booking.where(product: current_user.products)
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :address, :city, :photo, :capacity, :price, :latitude, :longitude, :start_date, :end_date, :status)
  end

  def set_product
    if Product.find_by(id: params[:id]).nil?
      redirect_to error_path
    else
      @product = Product.find(params[:id])
      authorize @product
    end
  end

  def set_user
    @user = current_user
  end

  def database_search
    @markers = Product.all
  end
end
