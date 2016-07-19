class StaticPagesController < ApplicationController
  def home
    redirect_to current_user.is_admin? ? admin_orders_path : products_path
  end

  def help
  end

  def about
  end

  def contact
  end
end
