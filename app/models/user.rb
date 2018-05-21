class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	
	mount_uploader :avatar, AvatarUploader

	has_many :posts, foreign_key: "author_id"

	has_many :comments

	has_many :commented_posts, through: :comments, source: :post

	has_many :sent_friendships, class_name: "Friendship", foreign_key: "sender_id"
	has_many :wanting_friends, through: :sent_friendships, source: :user

	has_many :received_friendships,  class_name: "Friendship", foreign_key: "receiver_id"
	has_many :wanted_friends, through: :received_friendships, source: :user
end
