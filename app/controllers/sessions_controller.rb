class SessionsController < ApplicationController
  def new
    redirect_to '/' if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        flash[:success] = "Welcome to Cleany!"
        redirect_back_or user
      else
        flash[:warning] = "Please active your account first!"
        redirect_to root_path
      end
    else
      flash.now[:error] = "Login error!"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You are logged out"
    redirect_to root_path
  end
end
