class Admin::ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = @products.paginate page: params[:page]
  end

  def new
    @categories = Category.all
  end

  def create
    if @product.save
      flash[:success] = t :success
      redirect_to admin_products_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t :success
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:danger] = t :error
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :name, :price_tag, :classify, :image,
      :quantity, :category_id
  end
end
