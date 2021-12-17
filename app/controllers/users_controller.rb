class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:danger] = t ".not_found_user"
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def destroy; end

  private
  def user_params
    params
      .require(:user).permit :name, :email, :password, :password_confirmation
  end
end
