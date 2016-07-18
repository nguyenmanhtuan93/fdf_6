class Admin::OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = @orders.ordered_order.paginate page: params[:page]
    @q = @orders.ransack params[:q]
    @orders = @q.result.paginate page: params[:page]
    @q.build_sort if @q.sorts.empty?
    @statuses = Order.statuses
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
