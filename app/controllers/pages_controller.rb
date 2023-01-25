class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    all_products = Product.all
    sorted_products = all_products.sort_by { |product| product.average_rating[:average] }.reverse
    @top_rated = sorted_products.first(5)
  end
end
