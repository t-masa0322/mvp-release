class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = "#"

    mail(to: @user.email, subject: "アカウント認証のご案内")
  end

  def activation_success_email(user)
    @user = user

    mail(to: @user.email, subject: "アカウント認証が完了しました")
  end
end
