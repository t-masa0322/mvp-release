class SignupProfilesController < ApplicationController
  before_action :set_signup_user

  def edit
    @user.profile_step = true
  end

  def update
    @user.profile_step = true

    if @user.update(signup_profile_params)
      session.delete(:signup_user_id)
      auto_login(@user)
      session[:initial_plant_selection] = true
      redirect_to initial_plants_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_signup_user
    @user = User.find_by(id: session[:signup_user_id])
    redirect_to new_signup_path, alert: "最初からやり直してください" unless @user
  end

  def signup_profile_params
    params.require(:user).permit(:name, :display_name)
  end
end
