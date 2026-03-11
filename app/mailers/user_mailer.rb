class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = edit_signup_profile_url(token: @user.activation_token)

    mail(to: @user.email, subject: "アカウント認証のご案内")
  end

  def activation_success_email(user)
    @user = user

    mail(to: @user.email, subject: "アカウント認証が完了しました")
  end

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(token: @user.reset_password_token)

    mail(to: @user.email, subject: "パスワード再設定のご案内")
  end
end
