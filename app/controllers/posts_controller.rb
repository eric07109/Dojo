class PostsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	impressionist :actions => [:show]

	def index
		category_id = params[:category_id]
		@posts = Post.where("posts.published" => true)
		if params[:category_id]
			@posts = Post.joins(:post_category_mappings).where("posts.published" => true, "post_category_mappings.category_id" => category_id)
		end
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
		@comments = @post.comments.limit(20)
	end

	def add_collection
		@collection = current_user.collections.build(post_id: params[:id])
		@collection.save!
		respond_to :js, :html
	end

	def remove_collection
		@collection = current_user.collections.where({post_id: params[:id]})
		@collection.destroy_all
		respond_to :js, :html
	end

	def feeds
		@user_count = User.count
		@post_count = Post.count
		@comment_count = Comment.count
		@top_users = User.joins(:comments).select('users.*, COUNT(comments.id) as count').group('users.id').order('count DESC').limit(10)
		@top_posts = Post.joins(:comments).select('posts.*, COUNT(comments.id) as count').group('posts.id').order('count DESC').limit(10)
	end

	private
	def post_params
		params.require(:post).permit(:title, :content, :privacy, :attachment, categories_attributes: [:category_id])
	end
end
