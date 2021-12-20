class FriendRequest < ApplicationRecord
  belongs_to :requested, class_name: 'User', foreign_key: 'requested_id'
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
end
