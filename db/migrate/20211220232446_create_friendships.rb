class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    drop_table :friendships
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :friend_id
      t.boolean :pending, default: :true

      t.timestamps
    end
  end
end
