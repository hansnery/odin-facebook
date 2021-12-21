class UsersController < ApplicationController
  def index
    @users = User.all
    @search = params["search"]
    if @search.present?
      @users = User.where(name: @search)
    end
  end

  def show
    @post = Post.new
    @user = User.find(params[:id])
  end

  def befriend
    @user = User.all.find(params[:id])
    @friendship = Friendship.create(user_id: current_user.id, friend_id: @user.id)
    @friendship.save
    redirect_back fallback_location: root_path
  end

  def break_friendship
    @user = User.all.find(params[:id])
    Friendship.where(user_id: current_user.id, friend_id: @user.id).destroy_all
    redirect_back fallback_location: root_path
  end
end
