require 'net/http'
require 'uri'
require 'json'


class IpToLocation
  def self.fetch(ip)   
    params = "?access_key="
    base_url = ENV['BASE_URL']   
    access_key = ENV['KEY']
    url = URI(base_url + ip + params + access_key)      
    res = Net::HTTP.get(url)
    JSON.parse(res)
  end
end