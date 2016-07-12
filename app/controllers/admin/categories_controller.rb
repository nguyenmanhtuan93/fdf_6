class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = @categories.paginate page: params[:page]
  end

  def show
    @products = @category.products.paginate page: params[:page]
  end

  def new
    @category.products.build
    @classify = Product.classifies
  end

  def create
    if @category.save
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :success
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    @categories = Category.all.paginate page: params[:page]
    respond_to do |format|
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name,
      products_attributes: [:name, :price_tag, :quantity, :image,
      :classify, :_destroy]
  end
end
