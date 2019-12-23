class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Reset Password"
  end

  def admin_password_reset admin
    @admin = admin
    mail to: admin.email, subject: "Reset Admin Password"
  end
end
