class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :ensure_own_post, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user).with_attached_image.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_own_post
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:body, :image)
  end
end
