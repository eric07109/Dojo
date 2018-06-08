class PostsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	impressionist :actions => [:show]

	def index
		@posts = Post.where("posts.published" => true)
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

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def add_collection
		@collection = current_user.collections.build(collection_params)
		@collection.save
		redirect_back fallback_location: posts_path(:post_id)
	end

	def remove_collection
		@collection = current_user.collections.where({post_id: params[:post_id]})
		@collection.destroy_all
		redirect_back fallback_location: posts_path(:post_id)
	end

	private
	def post_params
		params.require(:post).permit(:title, :content, :privacy, :attachment, categories_attributes: [:category_id])
	end

	def collection_params
		params.permit(:post_id)
	end

end
