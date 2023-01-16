module IpstackService
  class ClientConnect #< BaseConnect 
    class << ClientConnect
      def get(path)     
        client.get do |req|
          req.url "#{path}"
          puts "!!!!!#{IpstackService::Config.access_key}"
          req.params['access_key'] = IpstackService::Config.access_key
        end  
      end

      private

      def client
        @client =
          Faraday.new(:url => IpstackService::Config.base_url) do |client|
            #client.request :url_encoded
            client.request :json
            client.response :logger
            client.response :json, content_type: /\bjson$/
            #client.use :(resp_error)
            client.adapter Faraday.default_adapter          
            client.headers['Accept'] = 'application/json'
            client.headers['Content-Type'] = 'application/json'
          end 
      end

      # def resp_error
      #     IpstackService::Error_Handler
      # end
      
    end 
  end
end
