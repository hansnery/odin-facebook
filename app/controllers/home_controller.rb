class HomeController < ApplicationController
  def index
    if user_signed_in?
      @post = Post.new
      @friends = current_user.friends
      @latest_posts = []
      @friends.each do |friend|
        friend.posts.map { |post| @latest_posts << post }
      end
      current_user.posts.map { |post| @latest_posts << post }
      @latest_posts = @latest_posts.sort_by(&:created_at).reverse
      @comment = Comment.new
    end
  end
end
