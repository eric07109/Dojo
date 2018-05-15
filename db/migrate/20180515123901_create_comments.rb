class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|

      t.timestamps
      t.string :content, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
    end
  end
end
