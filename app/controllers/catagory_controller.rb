class CatagoryController < ApplicationController
	def show
		render_success_response(Catagory.find(params[:id]), 200)
	end

	def index
		render_success_response(Catagory.all, 200)
	end

	def update
		cat = Catagory.update params[:id], catagory_params
		render_success_response(cat, 200)
	end

	def create
		cat = Catagory.create catagory_params
		render_success_response(cat, 200)
	end

	def destroy
		Catagory.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def catagory_params
		params.permit(:title, :slug)
	end
end
