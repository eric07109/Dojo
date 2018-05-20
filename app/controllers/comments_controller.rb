class CommentsController < ApplicationController
	before_action :authenticate_user!
	
	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			redirect_back fallback_location: posts_path
		end
	end

	private
	def comment_params
		params.permit(:content, :post_id)
	end
end
