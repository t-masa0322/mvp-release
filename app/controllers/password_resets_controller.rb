class PasswordResetsController < ApplicationController
  before_action :set_user_from_token, only: %i[edit update]

  def new
  end

  def create
    @user = User.find_by(email: password_reset_params[:email])

    if @user
      @user.deliver_reset_password_instructions!
    end

    redirect_to login_path, notice: "パスワード再設定メールを送信しました"
  end

  def edit
  end

  def update
    @user.password = password_params[:password]
    @user.password_confirmation = password_params[:password_confirmation]

    if @user.change_password(password_params[:password])
      redirect_to login_path, notice: "パスワードを再設定しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_from_token
    @user = User.load_from_reset_password_token(params[:token])
    return if @user

    redirect_to new_password_reset_path, alert: "無効なURLです"
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
