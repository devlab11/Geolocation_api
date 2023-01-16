require 'rails_helper'

RSpec.describe 'GeolocationsController', type: :request do
  describe "GET /index" do
    before do
      get '/api/v1/geolocations'
    end
    it  'returns status code 200' do
      puts ">>>>>>"  
      puts response  
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected recipe attributes" do   
      json_response = JSON.parse(response.body)
      if json_response != nil          
        json_response.each { |json_response| expect(json_response.keys).to match_array(["id", "ip", "location_data", "created_at", "updated_at"])}       
      end  
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do 

      let(:valid_params) {
        {ip: "134.201.250.178"}
    }

      before do           
        post '/api/v1/geolocations', params: valid_params#, headers: {"Content-Type": "application/json"}
        
      end

      it "returns status code 200" do  
        puts valid_params
        puts "response #{response.body}"      
        expect(response).to have_http_status(:success)
      end

    #   it 'creates ip with the correct parametrs' do
    #     post "/api/v1/geolocations/", params: valid_params, headers: {"Content-Type": "application/json"}
        
    #     expect(Geolocation.last).to have_attributes valid_params["ip"]
    #   end      
    end

    # context 'with invalid parameters' do
    #   before do
    #     post '/api/v1/geolocations', params:
    #                       { ip: ''}
    #   end     
    # end
  end
end  
