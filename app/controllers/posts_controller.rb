class PostsController < ApplicationController
  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Posted successfully"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_back fallback_location: root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def like
    @post = Post.all.find(params[:id])
    @like = Like.create(user_id: current_user.id, post_id: @post.id)
    @like.save
    redirect_back fallback_location: root_path
  end

  def dislike
    @post = Post.all.find(params[:id])
    Like.where(user_id: current_user.id, post_id: @post.id).destroy_all
    redirect_back fallback_location: root_path
  end

  private

    def post_params
      params.require(:post).permit(:text)
    end
end
