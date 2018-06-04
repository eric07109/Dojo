class UsersController < ApplicationController
	def index
	end

	def show
		@user = User.find(params[:id])
		@user_published_posts = @user.published_posts
		@user_comments = @user.comments
		@user_unpublished_posts = @user.unpublished_posts
	end
end
