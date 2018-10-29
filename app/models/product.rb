class Product < ApplicationRecord
	belongs_to :catagory
	has_many :product_variations

	validates_presence_of     :slug
	validates_uniqueness_of   :slug
end
