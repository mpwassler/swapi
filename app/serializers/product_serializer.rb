class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :description, :catagory, :product_variations
end
