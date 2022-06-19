class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    flash[:success] = "NEW"
  end
  

  def index
    flash[:success] = "INDEX"
    @posts = Post.all.order(created_at: :desc)
    # @post = Post.find(params[:id])
  end

  def create
    flash[:success] = "CREATE"
    @post = Post.find(params[:post_id])
    # @text = params[:text]
    # @text.to_s
    @comment = Comment.create(comment_params) #text: :text, user_id: current_user.id, post_id: @post.id
    @post.comments << @comment
    @post.save
    # @comment.save
    if @comment.save
      flash[:success] = "Commented successfully"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_back fallback_location: root_path
  end

  # def destroy
  #   @article = Article.find(params[:article_id])
  #   @comment = @article.comments.find(params[:id])
  #   @comment.destroy

  #   flash.notice = "Comment deleted!"

  #   redirect_to article_path(@article)
  # end
  
  private

    def comment_params
      params.require(:comment).permit(:text, :user_id, :post_id, :parent)
    end
end
