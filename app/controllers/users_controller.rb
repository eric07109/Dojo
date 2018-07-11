class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@users = User.all
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

	def accept_friendship
		@friendship = current_user.unapproved_friended.where({ sender_Id: params[:id]})
		@friendship.update(approved: true)
		respond_to :js, :html
	end

	def ignore_friendship
	end

	def edit
		@user = User.find(params[:id])
	end 

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path(@user)
	end

	def update_admin
		@user = User.find(params[:id])
		@user.update(admin_user_params)
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:description, :avatar)
	end

	def admin_user_params
		params.permit(:admin)
	end
end
