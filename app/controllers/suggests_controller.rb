class SuggestsController < ApplicationController
  load_and_authorize_resource

  def index
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.build suggest_params
    respond_to do |format|
      format.html {redirect_to @comment.product}
      format.js
    end
  end

  private
  def suggest_params
    params.require(:suggest).permit :content, :user_id
  end
end
