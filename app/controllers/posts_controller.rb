class PostsController < ApplicationController
	

	def index
		@posts = Post.where(published: true)
		@categories = Category.all
	end

	def new
		@post = Post.new()
		@categories = Category.all
	end

	def create
		@post = current_user.posts.build(post_params)
		
		@categories = params[:category][:id]

		params[:commit] == "Create Post" ? @post.published = true : @post.published = false

		# create post category mapping from the selected categories
		if @post.save
			@categories.each { |c|
				c.to_i
				@post.post_category_mappings.create([
					{category_id: c}
				])
			}
		else
			logger.debug "#{@post.errors.full_messages.to_sentence}"
		end

		#todo: if stash, redirect to user profile
		redirect_back fallback_location: posts_path
	end


	private
	def post_params
		params.require(:post).permit(:title, :content, :privacy, categories_attributes: [:category_id])
	end

end
