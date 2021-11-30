class PostsController < ApplicationController
  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Posted successfully"
      redirect_to posts_path
    else
      flash[:error] = "Something went wrong"
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
      params.require(:post).permit(:text)
    end
end
