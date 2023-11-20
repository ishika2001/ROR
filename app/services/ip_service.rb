# frozen_string_literal: true

# app/services/ip.rb
require 'net/http'
require 'json'

class IpService
  def initialize(ip_client)
    @ip_client = ip_client
  end

  def get_ip_address
    uri = URI('https://api64.ipify.org?format=json')
    response = Net::HTTP.get(uri)
    JSON.parse(response)['ip']
  end
end
