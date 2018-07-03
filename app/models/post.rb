class Post < ApplicationRecord
	validates_presence_of :title, :content
	
	mount_uploader :attachment, AttachmentUploader

	is_impressionable

	belongs_to :author, :class_name => "User", :foreign_key => "author_id"

	has_many :post_category_mappings, dependent: :destroy
	has_many :categories, through: :post_category_mappings
	has_many :comments, dependent: :destroy
	has_many :commented_user, through: :comments, source: :user

	#for creating post category mapping in post new action
	accepts_nested_attributes_for :categories

	has_many :collections
	has_many :collected_user, through: :collections, source: :user

	def self.readable_by(user)
		Post.where(published: true, privacy: "all").or(
			where(published: true, privacy: "myself", author_id: user.id)).or(
			where(published: true, privacy: "friend", author_id: user.approved_friends)).or(
			where(published: true, privacy: "friend", author_id: user.accepted_friends))
	end

	def commented?
		return self.comments != []
	end

	def published?
		return self.published
	end

end
