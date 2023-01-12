class ApplicationController < ActionController::API
    # protect_from_forgery: :exception 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
    rescue_from ActionController::ParameterMissing, with: :bad_request 

    def bad_request
        render json: {status:'ERROR', message: 'param is missing or the value is empty'}, status:400
    end

    def routing_error
        render json: {status:'ERROR', message: 'No route matches'}, status:404
    end

    private
    def record_not_found
        render json: {status:'ERROR', message: 'Record Not Found'}, status:404
    end 
end
