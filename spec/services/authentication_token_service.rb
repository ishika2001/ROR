require 'rails_helper'

describe AuthenticationTokenService do 
  describe '.call' do
    it 'return an authentication token' do 
      expect(described_class.call).to eq('123')
    end
  end
end