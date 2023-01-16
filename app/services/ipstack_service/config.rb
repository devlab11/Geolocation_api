module IpstackService
    class Config   
        class << Config
        
            def access_key
                ENV['KEY_IPSTACK']
            end 

            def base_url
                ENV['BASE_URL_IPSTACK']  
            end 

            def service_name
                ENV['SERVICE_PROVIDER_IPSTACK']
            end 
        end  
    end     
end