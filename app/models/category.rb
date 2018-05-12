class Category < ApplicationRecord
	has_many :post_category_mappings
	has_many :posts, through: :post_category_mappings
end
