class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|

      t.timestamps
    end
    add_reference :friend_requests, :requested, index: true
    add_reference :friend_requests, :requester, index: true
  end
end
