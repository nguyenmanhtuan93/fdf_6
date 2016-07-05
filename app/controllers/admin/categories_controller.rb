class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = @categories.paginate page: params[:page]
  end

  def show
    @products = @category.products.paginate page: params[:page]
  end

  def new
  end

  def create
    if @category.save
      flash[:success] = t :success
      redirect_to admin_categories_path
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
    flash[:danger] = t :error
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
