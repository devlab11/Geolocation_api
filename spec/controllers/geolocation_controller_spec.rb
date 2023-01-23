require 'rails_helper'
require 'factory_bot'

RSpec.describe 'GeolocationsController', type: :request do  
  let(:service) { IpstackService::Api::V1::GetClient}
  let!(:service_params) { 
        {ip: "134.201.250.178"}
    }  

  describe "GET /index" do
    before do
      get '/api/v1/geolocations'
    end
    it  'returns status code 200' do       
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected recipe attributes" do   
      json_response = JSON.parse(response.body)
      if json_response != nil          
        json_response.each { |json_response| expect(json_response.keys).to match_array(["id", "ip", "location_data", "created_at", "updated_at"])}       
      end  
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      geo = Geolocation.create(service_params)
      get '/api/v1/geolocations', params: { id: geo.to_param }    
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /create' do
    it 'returns coorect instance' do      
      @message = Geolocation.create(service_params)    
      @message.should be_an_instance_of Geolocation
    end
  end

end  
