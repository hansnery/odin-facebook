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

  private

    def post_params
      params.require(:post).permit(:text)
    end
end
