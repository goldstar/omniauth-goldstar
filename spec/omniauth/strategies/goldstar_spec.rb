require 'spec_helper'

describe OmniAuth::Strategies::Goldstar do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = [:goldstar, 'appid', 'secret', 'https://www.example.com', @options || {}].compact
    OmniAuth::Strategies::Goldstar.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('goldstar')
    end

    it 'should have correct site' do
      expect(subject.client.site).to eq('https://www.example.com')
    end

    it 'should have correct authorize url' do
      expect(subject.client.authorize_url).to eq('https://www.example.com/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.client.token_url).to eq('https://www.example.com/oauth/access_token')
    end

  end

  describe 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the name' do
      expect(subject.info[:name]).to eq(raw_info_hash['name'])
    end

    it 'should returns the email' do
      expect(subject.info[:email]).to eq(raw_info_hash['email_address'])
    end

    it 'should returns the avatar url' do
      expect(subject.info[:avatar_url]).to eq(raw_info_hash['avatar_url'])
    end

    it 'should returns the privileges' do
      expect(subject.info[:privileges]).to eq(raw_info_hash['privileges'])
    end
  end
end

private

def raw_info_hash
  {
    'name' => 'Foo Bar',
    'email_address' => 'foo@example.com',
    'avatar_url' => 'http://example.com/avatar.jpg',
    'privileges' => 'developer'
  }
end
