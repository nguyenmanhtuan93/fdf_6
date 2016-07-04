class ProductsController < ApplicationController
  def index
    @products = Product.order(rating: :desc).paginate page: params[:page]
  end

  def show
    @product = Product.find_by_id params[:id]
  end
end
