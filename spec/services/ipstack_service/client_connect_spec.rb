require 'rails_helper'

RSpec.describe IpstackService::Api::V1::GetClient do    
        let!(:response) do 
            {                 
            "ip": "134.201.250.201",
            "type": "ipv4",
            "continent_code": "NA",
            "continent_name": "North America",
            "country_code": "US",
            "country_name": "United States",
            "region_code": "CA",
            "region_name": "California",
            "city": "Los Angeles",
            "zip": "90012",
            "latitude": 34.0655517578125,
            "longitude": -118.24053955078125,
            "location": {
                "geoname_id": 5368361,
                "capital": "Washington D.C.",
                "languages": [
                    {
                        "code": "en",
                        "name": "English",
                        "native": "English"
                    }]}}        
        end    

        let!(:service_params) do
            {"ip": "134.201.250.201"}
        end

        let(:client_connect) { IpstackService::Api::V1::GetClient.new }       

        describe '#get_client_connect' do
            it { expect(client_connect).to be_a(IpstackService::Api::V1::GetClient) }
        end   


        describe '#response' do
            before do          
                allow(IpstackService::Api::V1::GetClient).to(receive(:get_request).with(service_params).and_return(response))          
            end           
        
            it "returns correctly data" do
                expect(response).to be_kind_of(Hash)
                expect(response).to have_key(:ip)
                expect(response).to have_key(:latitude)
                expect(response).to have_key(:longitude)
            end
        end 
    
end
