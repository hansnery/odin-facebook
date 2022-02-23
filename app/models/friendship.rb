class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: "friend_id"
  validates :friend_id, uniqueness: { scope: :user_id }
end
