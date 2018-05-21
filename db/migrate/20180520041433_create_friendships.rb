class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|

      t.timestamps
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.boolean :approved, default: false
    end
  end
end
