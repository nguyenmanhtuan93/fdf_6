class Admin::SuggestsController < ApplicationController
  load_and_authorize_resource

  def index
    @suggests = Suggest.order_by_time.paginate page: params[:page]
  end

  def destroy
    @suggest.destroy
    @suggests = Suggest.order_by_time.paginate page: params[:page]
    respond_to do |format|
      format.js
    end
  end
end
