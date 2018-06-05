class UpdatePostPublishedDefaultFalse < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:posts, :published, nil)
  end
end
