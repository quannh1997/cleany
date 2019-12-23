class Admin::Admin < ApplicationRecord
  attr_reader :reset_token
  has_secure_password


  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  def send_password_reset_email
    create_reset_digest
    UserMailer.admin_password_reset(self).deliver_now
  end

  def create_reset_digest
    @reset_token = Admin::Admin.new_token
    update_columns(reset_digest: Admin::Admin.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def password_reset_expired?
    Time.zone.now - reset_sent_at > 3600
  end

  def reset_password
    new_password = (0...6).map { (97 + rand(26)).chr }.join
    update_columns(password_digest: Admin::Admin.digest(new_password),
                  reset_digest:nil)
    return new_password
  end
  class << self
    def digest string
      cost = Admin::Admin.choose_cost
      BCrypt::Password.create(string, cost: cost)
    end

    def choose_cost
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
