class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_order

  def current_order
    @current_order = if user_signed_in?
      current_user.orders.find_by(status: "pending") || current_user.orders.build
    else
      nil
    end
  end
end
