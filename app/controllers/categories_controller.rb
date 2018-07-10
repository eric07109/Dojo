class CategoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin, only: [:index, :destroy, :update, :create]
	def index
		@categories = Category.all
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.post_category_mappings.present?
			flash[:alert] = "Category #{@category.name} is still being used. The delete action is denied"
			redirect_to categories_path
		else 
			@category.destroy
			redirect_back fallback_location: categories_path
		end
	end

	def create
		@category = Category.new(category_params)
		# Todo: catcth unique constraint
		begin 
			@category.save
		rescue ActiveRecord::RecordNotUnique
			flash[:alert] = "Category #{@category.name} has already existed. Two identical categories are not allowed."
		end
		redirect_back fallback_location: categories_path

	end

	def update
		@category = Category.find(params[:id])
		begin 
			@category.update(category_params)
		rescue ActiveRecord::RecordNotUnique
			flash[:alert] = "Category #{@category.name} has already existed. Two identical categories are not allowed."
		end
		redirect_back fallback_location: categories_path
	end

	private
	def category_params
		params.permit(:name)
	end
end
