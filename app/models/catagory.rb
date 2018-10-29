class Catagory < ApplicationRecord
	has_many :products

	validates_presence_of     :slug
	validates_uniqueness_of   :slug
end
