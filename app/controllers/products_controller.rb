class ProductsController < ApplicationController
  def index
    @filterrific = initialize_filterrific( Product, params[:filterrific],
      select_options: {sorted_by: Product.options_for_sorted_by,
        with_category_id: Category.options_for_select}
    ) or return
    @products = @filterrific.find.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    @comment = Comment.new
  end
end
