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
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    @friends = Friendship.where(user_id: current_user.id, pending: false)
    @latest_posts = []
    @friends.each do |friend|
      User.where(id: friend.friend_id)[0].posts.map { |post| @latest_posts << post }
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

  def post_new_comment
    @comment = Comment.new
  end

  private

    def post_params
      params.require(:post).permit(:text)
    end

end
