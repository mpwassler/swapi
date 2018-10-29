class ProductController < ApplicationController
	around_action :rescue_from_fk_contraint, only: [:update, :create]

	def rescue_from_fk_contraint
	  begin
	    yield
	  rescue ActiveRecord::InvalidForeignKey
	  	render_error_response({details: 'Did not set a valid Catagory Id'}, 400)
	    # Flash and render, render API json error... whatever
	  end
	end

	def show
		render_success_response(Product.find(params[:id]), 200)
	end

	def index
		render_success_response(Product.all, 200)
	end

	def update
		product = Product.update params[:id], product_params
		render_success_response(product, 200)
	end

	def create
		product = Product.create product_params
		render_success_response(product, 200)
	end

	def destroy
		Product.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def product_params
		params.permit(:title, :slug, :description, :catagory_id)
	end
end
