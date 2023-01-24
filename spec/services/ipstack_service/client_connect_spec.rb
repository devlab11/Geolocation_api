require 'rails_helper'
RSpec.describe 'IpstackService GetClient' do
  let!(:response) do
    { "ip": '134.201.250.201' }
  end

  let!(:service_params) do
    { "ip": '134.201.250.201' }
  end

  let(:client_connect) { IpstackService::Api::V1::GetClient.new }

  describe '#get_client_connect' do
    it { expect(client_connect).to be_a(IpstackService::Api::V1::GetClient) }
  end

  describe '#response' do
    before do
      allow(IpstackService::Api::V1::GetClient).to(receive(:get_request).with(service_params).and_return(response))
    end

    it 'returns correctly data' do
      expect(response).to be_kind_of(Hash)
      expect(response).to have_key(:ip)
      #   expect(response).to have_key(:latitude)
      #   expect(response).to have_key(:longitude)
    end
  end
end
