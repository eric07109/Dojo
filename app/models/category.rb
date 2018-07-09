class Category < ApplicationRecord
	has_many :post_category_mappings, dependent: :destroy
	has_many :posts, through: :post_category_mappings
end
