class PostsController < ApplicationController
  before_action :authenticate_user!

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
    # @post = Post.find(params[:comment][:id])
    @posts = Post.all.order(created_at: :desc)
    @friends = current_user.friends
    @latest_posts = []
    @friends.each do |friend|
      friend.posts.map { |post| @latest_posts << post }
    end
    current_user.posts.map { |post| @latest_posts << post }
    @latest_posts = @latest_posts.sort_by(&:created_at).reverse
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

  # def new_post_comment
  #   @comment = @commentable.comments.new comment_params
  #   @comment.user = current_user
  #   if @comment.save
  #     flash[:success] = "Commented successfully"
  #   else
  #     flash[:error] = "Something went wrong"
  #   end
  #   redirect_back fallback_location: root_path
  # end

  private

    def post_params
      params.require(:post).permit(:text)
    end

    # def comment_params
    #   params.require(:comments).permit(:body)
    # end
end
