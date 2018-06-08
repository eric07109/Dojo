class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
    	t.timestamps
    	t.integer :user_id, null: false
    	t.integer :post_id, null: false
    end
  end
end
