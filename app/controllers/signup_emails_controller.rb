class SignupEmailsController < ApplicationController
  def new
  end

  def create
    email = signup_email_params[:email]

    redirect_to complete_signup_email_path, notice: "#{email} に認証メールを送信しました"
  end

  def complete
  end

  private

  def signup_email_params
    params.require(:signup_email).permit(:email)
  end
end
