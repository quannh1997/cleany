class Admin::ResetPasswordController < ApplicationController
    def edit
        @admin = Admin::Admin.find_by email: params[:email]
        if @admin.authenticated?(:reset, params[:id]) and not @admin.password_reset_expired?
            new_password = @admin.reset_password
            result = '<div>New password for mail: '+@admin.email+' is "'+new_password+'"</div>'
            render html: result.html_safe
        else
            render html: '<div>Invalid url</div>'.html_safe
        end
    end
end
