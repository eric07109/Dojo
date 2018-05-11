class ChangeNullToTruePostAuthor < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :posts, :author_id, false
  end
end
