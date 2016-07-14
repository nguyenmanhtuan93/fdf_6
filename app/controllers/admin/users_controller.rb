class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.normal_users.paginate page: params[:page]
    @q = @users.ransack params[:q]
    @users = @q.result.paginate page: params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email
  end
end
