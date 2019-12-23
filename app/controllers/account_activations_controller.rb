class AccountActivationsController < ApplicationController
  include PartnerSessionsHelper
  def edit
    type = params[:type]
    if type == 'Partner'
      user = Partner.find_by(email: params[:email])
    else
      user = User.find_by(email: params[:email])
    end
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      if type == 'Partner'
        partner_log_in user
      else
        log_in user
      end
      flash[:success] = "Actived"
      redirect_to user
    else
      flash[:error] = "invalid link"
      redirect_to root_path
    end
  end
end
