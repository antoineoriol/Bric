class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
    @markers = @products.geocoded.map do |product|
      {
        lng: product.longitude,
        lat: product.latitude,
        info_window_html: render_to_string(partial: "info_window", locals: {product: product}),
        marker_html: render_to_string(partial: "marker", locals: {product: product})
      }
    end
  end

  def status
    @products = Product.where(status: params[:status])
  end

  def my_products
    @products = Product.where(user: current_user)
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
  end

  def my_bookings_as_owner
    @bookings = Booking.where(product: current_user.products)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo)
  end
end
