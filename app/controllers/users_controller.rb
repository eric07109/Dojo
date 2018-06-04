class UsersController < ApplicationController
	def index
	end

	def show
		@user = User.find(params[:id])
		@user_posts = @user.posts
		@user_comments = @user.comments
	end
end
