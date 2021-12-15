class UsersController < ApplicationController
  def index
    @users = User.all
    @search = params["search"]
    if @search.present?
      @searched_name = @search["name"].split(/\W+/)
      @users = User.where("name LIKE ?", "#{@searched_name[0]}")
    end
  end

  def show
    @post = Post.new
    @user = User.find(params[:id])
  end
end
