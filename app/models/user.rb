class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :confirmable, :omniauthable
  has_many :posts
  has_many :comments
  has_many :friendships
  has_many :friendship_requests, through: :friendships
  # scope :friends, lambda { joins(:friendships).where("user_id > ?", self.id) }
  # scope :friends, -> { joins(:friendships).where(user_id: self.id, pending: :false) }

  def has_pending_friendship_request?(someone)
    !Friendship.where(user_id: someone.id, friend_id: self.id, pending: :true).empty? ||
    !Friendship.where(user_id: self.id, friend_id: someone.id, pending: :true).empty?
  end

  def friends_with?(someone)
    !Friendship.where(user_id: someone.id, friend_id: self.id, pending: :false).empty? ||
    !Friendship.where(user_id: self.id, friend_id: someone.id, pending: :false).empty?
  end

  def has_sent_friendship_request?(someone)
    !Friendship.where(user_id: self.id, friend_id: someone.id, pending: :true).empty?
  end

  def has_received_friendship_request?(someone)
    !Friendship.where(user_id: someone.id, friend_id: self.id, pending: :true).empty?
  end
end
