class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	
	mount_uploader :avatar, AvatarUploader

	has_many :posts, foreign_key: "author_id"

	has_many :comments

	has_many :commented_posts, through: :comments, source: :post

	has_many :sent_friendships, :class_name => "Friendship", :foreign_key => "sender_id"
	has_many :sent_friends, through: :sent_friendships, source: :receiver

	has_many :received_friendships,  class_name: "Friendship", foreign_key: "receiver_id"
	has_many :received_friends, through: :received_friendships, source: :sender

	def sent_or_received_friendship_invitation(target)
		self.sent_friends.include?(target) or self.received_friends.include?(target)
	end
end
