class Api::V1::PostsController < ApiController    
	before_action :authenticate_user!, :except => [:index]
    def index
        @posts = Post.all
        render json: {
            data: @posts
        }
    end

    def show
        @post = Post.find_by(id: params[:id])
        if !@post
            render json: {
                message: "Can't find the photo!",
                status: 400
            }
        else
            render json: {
                data: @post
            }
        end
    end

    def create
        @post = Post.new(post_params)
        @categories = params[:categories].split(",")
        puts "Categories are #{@categories}"
        if @post.save
            @categories.each { |c|
				c.to_i
				@post.post_category_mappings.create([
					{category_id: c}
                ])
			}
            render json: {
                message: "Post created successfully",
                result: @post
            }
        else
            render json: {
                errors: @post.errors 
            }
        end
    end

    def update
        @post = Post.find_by(id: params[:id])
        @categories = params[:categories].split(",")
        if @post.update(post_params)
            @post.post_category_mappings.destroy_all
            @categories.each { |c|
				c.to_i
				@post.post_category_mappings.create([
					{category_id: c}
                ])
			}
            render json: {
                message: "Post updated successfully",
                result: @post
            }
        else
            render json: {
                errors: @post.errors 
            }
        end
    end

    def destroy
        @post = Post.find_by(id: params[:id])
        if @post.destroy
            render json: {
                message: "Post #{@post.id} is deleted."
            }
        else
            render json: {
                errors: @post.errors
            }
        end

    end

    private
    def post_params
        params.permit(:title, :content, :author_id, :published, :privacy, :attachment, categories: [:ids])
    end
end
