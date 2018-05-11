class UpdatePostPublishedDefault < ActiveRecord::Migration[5.1]
  def change
  	change_column_default(:posts, :published, 0)
  end
end
