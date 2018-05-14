class Post < ApplicationRecord
	validates_presence_of :title, :content
	
	mount_uploader :attachment, AttachmentUploader

	belongs_to :author, :class_name => "User", :foreign_key => "author_id"

	has_many :post_category_mappings
	has_many :categories, through: :post_category_mappings
	accepts_nested_attributes_for :categories
end
