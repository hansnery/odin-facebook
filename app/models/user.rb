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
  has_many :friends, through: :friendships
  # scope :friends, lambda { joins(:friendships).where("user_id > ?", self.id) }
  # scope :friends, -> { joins(:friendships).where(user_id: self.id, pending: :false) }

  def has_pending_friendship_request?(user)
    !Friendship.where(user_id: user.id, friend_id: self.id, pending: :true).empty?
  end

  def friends_with?(user)
    !Friendship.where(user_id: user.id, friend_id: self.id, pending: :false).empty?
  end
end
