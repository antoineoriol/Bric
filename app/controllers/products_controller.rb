class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
    authorize @product
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @booking = Booking.new
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to product_path(@product)
  end

  def destroy
    @product.destroy
    redirect_to my_products_path
  end

  def my_products
    @products = current_user.products
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
    params.require(:product).permit(:title, :description, :start_date, :end_date, :capacity, :price, :photo, :price, :capacity, :photo)
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
