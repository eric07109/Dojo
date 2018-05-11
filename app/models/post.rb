class Post < ApplicationRecord
	validates_presence_of :title, :content
	belongs_to :author, :class_name => "User", :foreign_key => "author_id"
end
