class ErrorsController < ApplicationController
	def not_authorized
	  render_error_response({detail: 'not authorized'}, 401)
	end

end
