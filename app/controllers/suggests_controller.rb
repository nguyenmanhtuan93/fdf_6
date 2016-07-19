class SuggestsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:index, :create, :update]

  def index
    @suggests = current_user.suggests.order(created_at: :desc).
      page params[:page]
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.build suggest_params
    if @suggest.save
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to suggests_path
  end

  def update
    if current_user.suggests.update_attributes
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to suggests_path
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to suggests_path
  end

  private
  def suggest_params
    params.require(:suggest).permit :content
  end
end
