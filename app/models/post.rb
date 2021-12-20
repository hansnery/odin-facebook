class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes
  scope :likes, lambda { joins(:likes).where("post_id > ?", self.id) }

  def liked?(user)
    !!self.likes.find{ |like| like.user_id == user.id }
  end

  # def self.likes
  #   return Like.all.where(post_id: self.id).count
  # end
end
