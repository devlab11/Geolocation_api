require 'json'

module IpstackService
    module Api 
        module V1
            class GetClient 
                class << GetClient
                    def get_request(ip)
                       
                        res = IpstackService::ClientConnect.get(
                            ip
                        )
                        puts "res#{res.body}"
                        
                    end    
                end 
            end
        end
    end 
end                
       
    



