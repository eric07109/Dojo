class Post < ApplicationRecord
	validates_presence_of :title, :content
	
	mount_uploader :attachment, AttachmentUploader

	is_impressionable

	belongs_to :author, :class_name => "User", :foreign_key => "author_id"

	has_many :post_category_mappings
	has_many :categories, through: :post_category_mappings
	has_many :comments
	has_many :commented_user, through: :comments, source: :user

	#for creating post category mapping in post new action
	accepts_nested_attributes_for :categories

	def commented?
		return self.comments != []
	end

end
