require_relative '../../app/services/ip_service'
require 'rails_helper'

describe IpService do
  let(:ip_client) { instance_double('ThirdPartyIpLibrary') }
  let(:ip_service) { IpService.new(ip_client) }

  it 'fetches IP address using third-party library' do
    allow(ip_client).to receive(:get_ip_address).and_return('2405:201:3027:e0e5:c20b:90b0:86cc:393e')

    result = ip_service.get_ip_address

    expect(result).to eq('2405:201:3027:e0e5:c20b:90b0:86cc:393e')
  end
end