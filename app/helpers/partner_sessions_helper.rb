module PartnerSessionsHelper
    def partner_log_in user
      session[:partner_id] = user.id
    end
  
    def partner_logged_in?
      current_partner.present?
    end
  
    def partner_log_out
      forget current_partner
      session.delete :partner_id
      @current_user = nil
    end
  
    def partner_remember user
      user.remember
      cookies.permanent.signed[:partner_id] = user.id
      cookies.permanent[:partner_remember_token] = user.remember_token
    end
  
    def partner_forget user
      user.forget
      cookies.delete :partner_id
      cookies.delete :partner_remember_token
    end
  
    def redirect_back_or default
      redirect_to(session[:forwarding_url] || default)
      session.delete :forwarding_url
    end
  
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  
    def current_partner
      if partner_id = session[:partner_id]
        @current_user ||= Partner.find_by id: partner_id
      elsif partner_id = cookies.signed[:partner_id]
        user = Partner.find_by id: partner_id
        if user&.authenticated?(:partner_remember, cookies[:partner_remember_token])
          partner_log_in user
          @current_user = user
        end
      end
    end
  end
  