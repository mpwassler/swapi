class OrdersController < ApplicationController

	before_action :authorize_as_admin, only: [:destroy]

	def show
		render_success_response(Order.find(params[:id]), 200)
	end

	def index
		render_success_response(Order.all, 200)
	end

	def update
		order = Order.update params[:id], order_params
		render_success_response(order, 200)
	end

	def create
		order = Order.create order_params
		render_success_response(order, 200)
	end

	def destroy
		Order.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def order_params
		params.permit(
			:billing_address_id,
			:shipping_address_id,
			:total,
			:status,
			:payment_status
		)
	end
end
