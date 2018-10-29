class ApplicationController < ActionController::Base

  include Knock::Authenticable

  protect_from_forgery with: :null_session

  rescue_from(ActiveRecord::RecordNotFound) do
    render_error_response({record: ['not found']}, 404)
  end

  rescue_from(ActionController::ParameterMissing) do |exception|
    parameter = exception.message.split.last
    render_error_response({parameter => ['can\'t be blank']}, 422)
  end

  def render_if_stale(resource, options = {})
    return unless stale?(resource)
    render_success_response(resource, 200, options)
  end

  def render_success_response(resource, status, options = {})
    render(
      json: response_json(data: resource, options: options),
      status: status
    )
  end

  def render_error_response(errors, status)
    render(
      json: response_json(errors: errors),
      status: status
    )
  end

  private

  def location_id
    params[:location_id]
  end

  def response_json(errors: nil, data: nil, options: {})
    serialized_errors = errors.present? ? serialized(errors, {}) : errors
    serialized_data   = data.present? ? serialized(data, options) : data
    {
      errors: serialized_errors,
      body:   serialized_data
    }
  end

  def serialized(data, options)
    return serialized_hash(data, options) if options[:serializable_hash]
    return data if non_serializable?(data)
    ActiveModelSerializers::SerializableResource.new(data, options).as_json
  end

  def serialized_hash(data, options)
    if data.is_a?(Array) && options[:each_serializer].present?
      data.map { |data_item| options[:each_serializer].call(data_item) }
    else
      options[:serializer].call(data)
    end
  end

  def non_serializable?(data)
    data.blank? || data.is_a?(Hash)
  end

  def authorize_as_admin
     return_unauthorized unless !current_user.nil? && current_user.is_admin?
  end

  def unauthorized_entity(entity_name)
    render_error_response({detail: "You are not authorized to preform this action"}, 401)
  end
end
