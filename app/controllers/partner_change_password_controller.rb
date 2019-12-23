class PartnerChangePasswordController < ApplicationController
    include PartnerSessionsHelper
    before_action :load_user
    before_action :correct_user

    def edit;end

    def update
        user = current_partner
        if user&.authenticate(params[:partner][:old_password])
            if params[:partner][:password].empty?
                user.errors.add :password, "Password can not empty"
                render :edit
            elsif user.update_attributes user_params
                flash[:success] = "Password has been changed"
                redirect_to @user
            else
                render :edit
            end
        else 
            flash.now[:danger] = "Password is wrong!"
            render :edit
        end
    end


    def correct_user
        redirect_to root_path unless @user&.current_partner? current_partner
    end

    def load_user
        @user = Partner.find_by_id(params[:id])
    end

    def user_params
        params.require(:partner).permit :password, :password_confirmation
    end
end
