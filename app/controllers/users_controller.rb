class UsersController < ApplicationController
	def index
	end

	def show
		@user = User.find(params[:id])
		@user_published_posts = @user.published_posts
		@user_comments = @user.comments
		@user_unpublished_posts = @user.unpublished_posts
		@user_collected_posts = @user.collected_posts
		@friends_to_be_approved = @user.friends_to_be_approved
		@friends_to_approve = @user.friends_to_approve
		@friends = @user.accepted_friends + @user.approved_friends
	end
end
