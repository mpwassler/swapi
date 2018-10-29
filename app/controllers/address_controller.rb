class OrderController < ApplicationController
	def show
		render_success_response(Address.find(params[:id]), 200)
	end

	def index
		render_success_response(Address.all, 200)
	end

	def update
		order = Address.update params[:id], address_params
		render_success_response(order, 200)
	end

	def create
		order = Address.create address_params
		render_success_response(order, 200)
	end

	def destroy
		Address.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def address_params
		params.permit(
			:first_name,
			:last_name,
			:city,
			:state,
			:postal_code,
			:address_line_1,
			:address_line_2,
			:phone,
			:email
		)
	end
end









