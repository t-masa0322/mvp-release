class SignupProfilesController < ApplicationController
  before_action :set_user_by_token

  def edit
  end

  def update
    if @user.update(signup_profile_params)
      auto_login(@user)
      @user.activate!
      redirect_to initial_plants_path, notice: "基本情報を登録しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.load_from_activation_token(params[:token])
    return if @user

    redirect_to root_path, alert: "無効なURLです"
  end

  def signup_profile_params
    params.require(:user).permit(:name, :display_name, :password, :password_confirmation)
  end
end
