class PostsController < ApplicationController
	

	def index
		@posts = Post.where(published: true).to_a
	end

	def new
		@post = Post.new()
	end

	def create
		@post = current_user.posts.build(post_params)

		if params[:commit] == "Create Post"
			@post.published = true
		end

		if @post.save
			redirect_back fallback_location: new_post_path 
		else
			logger.debug "#{@post.errors.full_messages.to_sentence}"
			redirect_back fallback_location: new_post_path 
		end
	end


	private
	def post_params
		params.require(:post).permit(:title, :content)
	end

end
