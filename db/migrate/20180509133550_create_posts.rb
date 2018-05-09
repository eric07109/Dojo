class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.string :title, null: false
      t.text :content, null: false
      t.integer :author, null: false
      t.boolean :published, null: false
      t.string :privacy
      t.integer :category
      #todo: add image uploader

    end
  end
end
