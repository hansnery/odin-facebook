class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
  end
  

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @post.comments << @comment
    @post.save
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
