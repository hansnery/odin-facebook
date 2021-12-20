class Friendship < ApplicationRecord
  belongs_to :user

  def self.requested_friendship?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  def self.friends?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.find_friendship_request(id1, id2)
    if Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Friendship.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Friendship.where(user_id: id1, friend_id: id2, confirmed: true)[0].id
    end
  end
end
