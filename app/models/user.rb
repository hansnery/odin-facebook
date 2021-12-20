class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :confirmable, :omniauthable
  has_many :posts
  has_many :friendships
  has_many :pending_friendship_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: "friend_id"

  def friends
    desired_friends = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    beg_friends = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = desired_friends + beg_friends
    User.where(id: ids)
  end

  def friends_with?(user)
    Friendship.confirmed_record?(id, user.id)
  end

  def send_friendship_request(user)
    friendships.create(friend_id: user.id)
  end
end
