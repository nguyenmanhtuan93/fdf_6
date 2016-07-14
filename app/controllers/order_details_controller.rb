class OrderDetailsController < ApplicationController
  before_action :find_order_detail, only: [:update, :destroy]
  before_action :check_product_exist_in_cart, only: :create
  after_action :update_total_pay, only: [:create, :update, :destroy]

  def index
    @order_details = current_order.order_details
  end

  def create
    @order_detail = current_order.order_details.build order_detail_params
    if @order_detail.save
      flash.now[:success] = t "success"
      respond_to do |format|
        format.html {redirect_to current_order}
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_to products_path
    end
  end

  def update
    if @order_detail.update_attributes order_detail_params
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to order_path current_order
  end

  def destroy
    if @order_detail.destroy
      flash[:success] = t "success"
      redirect_to current_order
    else
      flash[:danger] = t "error"
      redirect_to products_path
    end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit :quantity, :product_id
  end

  def find_order_detail
    @order_detail = current_order.order_details.find_by_id params[:id]
  end

  def check_product_exist_in_cart
    if order_detail = current_order.order_details.find_by(product_id:
      params[:order_detail][:product_id])
      order_detail.update_attributes quantity:
        (order_detail.quantity + params[:order_detail][:quantity].to_i)
      update_total_pay
      redirect_to current_order
    end
  end

  def update_total_pay
    current_order[:total_pay] = current_order.total_pay
    current_order.save
  end
end
