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
end
