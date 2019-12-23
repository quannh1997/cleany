class PartnerSessionsController < ApplicationController
  include PartnerSessionsHelper
  def new
    redirect_to '/' if partner_logged_in?
  end

  def create
    user = Partner.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      if user.activated?
        partner_log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:error] = "Please active your account first!"
        redirect_to root_path
      end
    else
      flash.now[:error] = "Login error!"
      render :new
    end
  end

  def destroy
    partner_log_out if partner_logged_in?
    flash[:success] = "You are logged out"
    redirect_to root_path
  end
end