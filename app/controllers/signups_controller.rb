class SignupsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(signup_params)

    if @user.save
      session[:signup_user_id] = @user.id
      redirect_to edit_signup_profile_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
