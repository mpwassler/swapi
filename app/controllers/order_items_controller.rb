class OrderItemsController < ApplicationController
	around_action :rescue_from_fk_contraint, only: [:update, :create]

	before_action :authorize_as_admin, only: [:destroy]

	def rescue_from_fk_contraint
	  begin
	    yield
	  rescue ActiveRecord::InvalidForeignKey
	  	render_error_response({details: 'Did not set a valid Product Variation, or Order Id'}, 400)
	    # Flash and render, render API json error... whatever
	  end
	end

	def show
		render_success_response(OrderItem.find(params[:id]), 200)
	end

	def index
		render_success_response(OrderItem.all, 200)
	end

	def update
		order_item = OrderItem.update params[:id], order_item_params
		render_success_response(order_item, 200)
	end

	def create
		order_item = OrderItem.create order_item_params
		render_success_response(order_item, 200)
	end

	def destroy
		OrderItem.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def order_item_params
		params.permit(
			:quantity,
			:order_id,
			:product_variation_id,
			:price,
			:total
		)
	end
end

