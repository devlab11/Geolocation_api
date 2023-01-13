require 'rails_helper'

RSpec.describe 'GeolocationsController', type: :request do
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
end