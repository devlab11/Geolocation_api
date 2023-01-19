require 'json'

module IpstackService
    module Api 
        module V1
            class GetClient 
                class << GetClient
                    def get_request(ip)                         
                        res = IpstackService::ClientConnect.get(ip)                       
                    end    
                end 
            end
        end
    end 
end                
       
    




