class CategoriesController < ApplicationController
	before_action :authenticate_user!
	def index
		@categories = Category.all
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_back fallback_location: @root
	end

	def create
		@category = Category.new(category_params)
		# Todo: catcth unique constraint
		if @category.save
			redirect_back fallback_location: @root
		end

	end

	def update
		@category = Category.find(params[:id])
		@category.update(category_params)
		redirect_back fallback_location: @root
	end

	private
	def category_params
		params.permit(:name)
	end
end
