class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|

      t.timestamps
    end
    add_reference :likes, :user, index: true
    add_reference :likes, :post, index: true
  end
end
