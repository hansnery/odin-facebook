class Friendship < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  # belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  validates :user_id, uniqueness: { scope: :friend_id }
end
