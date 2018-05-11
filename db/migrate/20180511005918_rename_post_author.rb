class RenamePostAuthor < ActiveRecord::Migration[5.1]
  def change
  	change_table :posts do |t|
  		t.rename :author, :author_id
  	end
  end
end
