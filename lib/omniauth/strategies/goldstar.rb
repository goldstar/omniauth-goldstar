require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Goldstar < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "goldstar"

      args [:client_id, :client_secret, :client_host]

      def client_options
        {
          :site => options['client_host'],
          :authorize_url => '/oauth/authorize',
          :token_url => '/oauth/access_token'
        }
      end

      option :authorize_params, {
        :type => 'web_server'
      }

      option :token_params, {
        :type => 'web_server'
      }

      option :provider_ignores_state, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email'],
          :avatar_url => raw_info['profile_photo_url'],
          :privileges => raw_info['privileges']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/account.json', {:params => {:access_token => access_token.token}}).parsed
      end

      def client
        ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(client_options))
      end

    end
  end
end
