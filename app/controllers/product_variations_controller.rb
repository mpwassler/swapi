class ProductVariationsController < ApplicationController
	around_action :rescue_from_fk_contraint, only: [:update, :create]

	before_action :authorize_as_admin, only: [:destroy, :update, :create]

	def rescue_from_fk_contraint
	  begin
	    yield
	  rescue ActiveRecord::InvalidForeignKey
	  	render_error_response({details: 'Did not set a valid Product Id'}, 400)
	    # Flash and render, render API json error... whatever
	  end
	end

	def show
		render_success_response(ProductVariation.find(params[:id]), 200)
	end

	def index
		render_success_response(ProductVariation.all, 200)
	end

	def update
		product_variation = ProductVariation.update params[:id], product_variation_params
		render_success_response(product_variation, 200)
	end

	def create
		product_variation = ProductVariation.create product_variation_params
		render_success_response(product_variation, 200)
	end

	def destroy
		ProductVariation.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def product_variation_params
		params.permit(:title, :sku, :price, :product_id)
	end
end
