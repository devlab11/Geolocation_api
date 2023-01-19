module IpstackService
  class ErrorHandler  < Faraday::Middleware
    def call(env)        
      @app.call(env).on_complete do |env|
        body = env.response_body                    
        body_of_error = error_body(body)         
        if body_of_error.key?('success')         
          if body_of_error["success"] == false           
            raise IpstackService::Api::Exception::ServiseProviderError, servise_provider_error(body_of_error)  
          end          
        else         
          case env[:status].to_i
          when 400
            raise IpstackService::Api::Exception::BadRequest, error_message_400(body_of_error)                  
          when 500            
            raise IpstackService::Api::Exception::InternalServerError, error_message_500(body_of_error, "Something is technically wrong.")                    
          end           
        end  
      end  
    end  

    def initialize(app)
      super app
      @parser = nil
    end  
    private

    def servise_provider_error(body)     
      "code #{body['error']['code']} - #{body['error']['type']}"      
    end

    def error_message_400(response)      
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)    
      if not body.nil? and not body.empty? and body.kind_of?(String)    
        body = ::JSON.parse(body)
      end
     
      
    end

    def error_message_500(response, body=nil)      
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end  