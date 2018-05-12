class PostsController < ApplicationController
	

	def index
		@posts = Post.where(published: true)
	end

	def new
		@post = Post.new()
	end

	def create
		@post = current_user.posts.build(post_params)

		if params[:commit] == "Create Post"
			@post.published = true
		end

		if @post.published == true and @post.save
			redirect_back fallback_location: posts_path 
		elsif @post.published == false and @post.save
			#todo: redirect to user profile
			redirect_to posts_path 
		else
			logger.debug "#{@post.errors.full_messages.to_sentence}"
		end
	end


	private
	def post_params
		params.require(:post).permit(:title, :content, :privacy)
	end

end
