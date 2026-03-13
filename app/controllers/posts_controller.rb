class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = Post.includes(:user).with_attached_image.order(created_at: :desc)
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

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end
end
