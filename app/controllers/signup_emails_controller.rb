class SignupEmailsController < ApplicationController
  def new
  end

  def create
    @user = User.find_or_initialize_by(email: signup_email_params[:email])

    if @user.new_record?
      @user.save!
    end

    @user.send(:setup_activation)
    @user.save!
    @user.send(:send_activation_needed_email!)

    redirect_to complete_signup_email_path, notice: "#{@user.email} に認証メールを送信しました"
  rescue StandardError => e
    flash.now[:alert] = e.message
    render :new, status: :unprocessable_entity
  end

  def complete
  end

  private

  def signup_email_params
    params.require(:signup_email).permit(:email)
  end
end
