class CreateSimpleComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.integer :parent
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
