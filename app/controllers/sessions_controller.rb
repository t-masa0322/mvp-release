class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    @user = login(session_params[:email], session_params[:password])

    if @user
      redirect_to home_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
