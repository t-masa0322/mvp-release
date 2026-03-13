class MypagesController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(mypage_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def mypage_params
    params.require(:user).permit(:display_name, :profile_image)
  end
end
