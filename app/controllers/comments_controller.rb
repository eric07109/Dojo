class CommentsController < ApplicationController
	before_action :authenticate_user!
	
	def create
		@post = Post.find(params[:post_id])
		@comment = current_user.comments.build(comment_params) if Post.readable_by(current_user).include?(@post)
		if @comment.save
			redirect_back fallback_location: posts_path
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_back fallback_location: posts_path
	end

	private
	def comment_params
		params.permit(:content, :post_id)
	end
end
