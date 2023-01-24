class ApplicationController < ActionController::API
  # protect_from_forgery: :exception

  rescue_from IpstackService::Api::Exception::ServiseProviderError, with: :servise_error_response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from IpstackService::Api::Exception::BadRequest, with: :bad_request
  rescue_from IpstackService::Api::Exception::InternalServerError, with: :internal_server_error

  def parameter_missing
    render json: { errors: [{ title: 'ParameterMissing',
                              status: 400,
                              detail: 'param is missing or the value is empty' }] }, status: 400
  end

  def bad_request(error)
    render json: { errors: [{ title: 'BadRequest',
                              status: 400,
                              detail: error }] }, status: 400
  end

  def internal_server_error(error)
    puts error
    render json: { errors: [{ title: 'InternalServerError',
                              status: 500,
                              detail: error }] }, status: 500
  end

  def routing_error
    render json: { errors: [{ title: 'No route matches',
                              status: 404 }] }, status: 404
  end

  def servise_error_response(error)
    render json: { errors: [{ title: 'ServiseProviderError',
                              status: 404,
                              detail: error }] }, status: 404
  end

  private

  def record_not_found
    render json: { errors: [{ title: 'RecordNotFound',
                              status: '404',
                              detail: 'Record Not Found' }] }, status: 404
  end
end
