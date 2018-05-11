class Post < ApplicationRecord
	validates_presence_of :title, :content, :published
	belongs_to :author, :class_name => "User", :foreign_key => "author_id"
end
