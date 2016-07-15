class Admin::OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = @orders.paginate page: params[:page]
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t :success
    else
      flash[:error] = t :error
    end
    redirect_to admin_orders_path
  end

  def destroy
    if @order.destroy
      flash[:success] = t :success
    else
      flash[:error] = t :error
    end
    redirect_to admin_orders_path
  end

  private
  def order_params
    params.require(:order).permit :status
  end
end
