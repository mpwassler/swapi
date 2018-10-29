class ProductsController < ApplicationController
	around_action :rescue_from_fk_contraint, only: [:update, :create]

	before_action :authorize_as_admin, only: [:destroy, :update, :create]

	def rescue_from_fk_contraint
	  begin
	    yield
	  rescue ActiveRecord::InvalidForeignKey
	  	render_error_response({details: 'Did not set a valid Catagory Id'}, 400)
	    # Flash and render, render API json error... whatever
	  end
	end

	def show
		product = Product.find_by( slug: params[:slug])
		if product
			render_success_response(Product.find_by( slug: params[:slug]), 200)
		else
			render_error_response({details: 'no product found'}, 404)
		end
	end

	def index
		render_success_response(Product.all, 200)
	end

	def update
		product = Product.find_by(slug: params[:slug]).update(product_params)
		if product
			render_success_response(product, 200)
		else
			render_error_response({details:  'no product found'}, 404)
		end

	end

	def create
		product = Product.create product_params
		if product
			render_success_response(product, 200)
		else
			render_success_response({details: 'product creation failed'}, 400)
		end

	end

	def destroy
		Product.find_by(slug: params[:slug]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def product_params
		params.permit(:title, :slug, :description, :catagory_id)
	end
end
