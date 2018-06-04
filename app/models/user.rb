class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	
	mount_uploader :avatar, AvatarUploader

	has_many :posts, foreign_key: "author_id"
	has_many :published_posts, -> {where(published: true)}, :class_name => "Post", :foreign_key => "author_id"
	has_many :unpublished_posts, -> {where(published: false)}, :class_name => "Post", :foreign_key => "author_id"

	has_many :comments

	has_many :commented_posts, through: :comments, source: :post

	#unapproved
	has_many :unapproved_friending, -> { where(approved: false) }, :class_name => "Friendship", :foreign_key => "sender_id"
	has_many :friends_to_be_approved, through: :unapproved_friending, source: :receiver

	has_many :unapproved_friended, -> { where(approved: false) }, class_name: "Friendship", foreign_key: "receiver_id"
	has_many :friends_to_approve, through: :unapproved_friended, source: :sender

	#approved
	has_many :approved_friending, -> { where(approved: true) }, :class_name => "Friendship", :foreign_key => "sender_id"
	has_many :accepted_friends, through: :approved_friending, source: :receiver

	has_many :approved_friended, -> { where(approved: true) }, class_name: "Friendship", foreign_key: "receiver_id"
	has_many :approved_friends, through: :approved_friended, source: :sender

	def friend_with?(user)
		self.accepted_friends.include?(user) or self.approved_friends.include?(user)
	end
end
