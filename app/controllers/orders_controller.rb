class OrdersController < ApplicationController
  load_and_authorize_resource except: :index

  def index
    @orders = current_user.orders.order(created_at: :desc).page params[:page]
  end

  def show
    @order_details = @order.order_details
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit :user_id, :total_pay, :payment, :status
  end
end
