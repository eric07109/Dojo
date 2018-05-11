class PostsController < ApplicationController
	

	def index
	end

	def new
		@post = Post.new()
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.published = 1
		if @post.save
			redirect_back fallback_location: new_post_path 
		else
			logger.debug "#{@post.errors.full_messages.to_sentence}"
			redirect_back fallback_location: new_post_path 
		end
	end


	private
	def post_params
		params.require(:post).permit(:title, :content, :published)
	end

end
