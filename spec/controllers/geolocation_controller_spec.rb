require 'rails_helper'
require 'factory_bot'

RSpec.describe 'GeolocationsController', type: :request do
  let(:service) { IpstackService::Api::V1::GetClient }
  let!(:ip_params) { create(:geolocation) }
  let!(:req_params) do
    {
      ip: ip_params.ip
    }
  end

  describe 'GET /index' do
    before do
      get '/api/v1/geolocations'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected recipe attributes' do
      json_response = JSON.parse(response.body)
      unless json_response.nil?
        json_response.each do |json_response|
          expect(json_response.keys).to match_array(%w[id ip location_data created_at updated_at])
        end
      end
    end
  end

  describe 'GET /show' do
    before do
      get "/api/v1/geolocations/#{ip_params.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to be_a(Hash)
    end

    it 'JSON body response contains expected recipe attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(%w[id ip location_data created_at updated_at]) unless json_response.nil?
    end
  end

  describe 'Geolocation' do
    it 'returns Geolocation' do
      @geo = Geolocation.create(req_params)
      expect(@geo).to be_a(Geolocation)
    end
  end

  describe 'GET /delete' do
    before do
      get "/api/v1/geolocations/#{ip_params.id}"
    end
    it 'destroy' do
      delete "/api/v1/geolocations/#{ip_params.id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to be_a(Hash)
    end
  end

  describe 'ParameterMissing Error' do
    let!(:expected_error_response) do
      [['errors',
        [{ 'detail' => 'param is missing or the value is empty', 'status' => 400, 'title' => 'ParameterMissing' }]]]
    end

    before do
      post '/api/v1/geolocations', params: { ip: '' }
    end
    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
    it 'raises an exception' do
      json_response = JSON.parse(response.body)
      expect(json_response).to match_array(expected_error_response)
    end
  end

  describe 'Routing Error' do
    let!(:expected_error_response) do
      [['errors', [{ 'status' => 404, 'title' => 'No route matches' }]]]
    end

    before do
      get '/api/v1/geolocationss'
    end
    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    it 'raises an exception' do
      json_response = JSON.parse(response.body)
      expect(json_response).to match_array(expected_error_response)
    end
  end
end
