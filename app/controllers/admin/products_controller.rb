class Admin::ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Product.ransack params[:q]
    @products = @q.result.paginate page: params[:page]
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
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
    if @product.destroy
      flash[:success] = t :success
    else
      flash[:danger] = t :error
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :name, :price_tag, :classify, :image,
      :quantity, :category_id
  end
end
