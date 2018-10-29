class UserController < ApplicationController

	before_action :authenticate_user,  only: [:index, :current, :update]
	before_action :authorize_as_admin, only: [:destroy]
	before_action :authorize,          only: [:update]

	def show
		render_success_response(User.find(params[:id]), 200, each_serializer: UserSerializer)
	end

	def index
		render_success_response(User.all, 200)
	end

	def update
		user = User.update params[:id], user_params
		render_success_response(user, 200, serializer: UserSerializer)
	end

	def create
		user = User.create user_params
		render_success_response(user, 200, serializer: UserSerializer)
	end

	def destroy
		User.find(params[:id]).destroy
		render_success_response({result: "record #{params[:id]} deleted"}, 200)
	end

	private

	def authorize
	    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
	 end

	def user_params
		params.permit(
			:first_name,
			:last_name,
			:role,
			:email,
			:password,
			:password_confirmation
		)
	end
end
