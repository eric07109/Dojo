class AddAttachmentToPost < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :attachment, :string
  end
end
