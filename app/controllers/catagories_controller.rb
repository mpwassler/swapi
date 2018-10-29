class CatagoriesController < ApplicationController

	before_action :authorize_as_admin, only: [:destroy, :update, :create]

	def show
		catagory = Catagory.find_by( slug: params[:slug])
		if product
			render_success_response(catagory, 200)
		else
			render_error_response({details: 'no catagory found'}, 404)
		end
	end

	def index
		render_success_response(Catagory.all, 200)
	end

	def update
		cat = Catagory.find_by( slug: params[:slug]).update(catagory_params)
		render_success_response(cat, 200)
	end

	def create
		cat = Catagory.create catagory_params
		render_success_response(cat, 200)
	end

	def destroy
		Catagory.find_by(slug: params[:slug]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def catagory_params
		params.permit(:title, :slug)
	end
end
