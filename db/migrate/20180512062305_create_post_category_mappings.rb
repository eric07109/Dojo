class CreatePostCategoryMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :post_category_mappings do |t|

      t.timestamps
      t.integer :post_id
      t.integer :category_id
    end
  end
end
