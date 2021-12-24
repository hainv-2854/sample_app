class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash.now[:danger] = t ".invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def check_activated user
    if user.activated
      log_in user
      check_remember user
      redirect_back_or user
    else
      flash[:warning] = t ".account_not_active"
      redirect_to root_url
    end
  end
end
