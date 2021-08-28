# OmniAuth Goldstar

This gem contains the Goldstar strategy for OmniAuth.

## Before You Begin

Get an ID and Secret for your app.  Goldstar OAuth credentials can only be created by console.

Create a client:

```ruby
Oauth2Client.create!(name: 'Smile', redirect_uri: 'https://yourapp.com/auth/goldstar/callback', application_logo: 'https://yourapp.com/images/logo.gif')
```

Note the new client's client_key and client_secret.  These are the app_id and app_secret that you'll need below. The app_host is the root domain of the server you created the client on (e.g. https://wwww.goldstar.com for production or http://0.0.0.0:3000 for development)

## Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-goldstar', '= 1.0.0'
```

Next, tell OmniAuth about goldstar. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
require 'omniauth-goldstar'

goldstar_config = if ENV['GOLDSTAR_APP_ID']
  {
    'app_id'     => ENV['GOLDSTAR_APP_ID'],
    'app_secret' => ENV['GOLDSTAR_APP_SECRET'],
    'app_host'   => ENV['GOLDSTAR_APP_HOST']
  }
else
  YAML.load_file(File.join(Rails.root, "config", "goldstar-oauth2.yml"))[Rails.env]
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :goldstar, goldstar_config['app_id'], goldstar_config['app_secret'], goldstar_config['app_host']
  # If you just want an unsafe login for development
  provider :developer, :fields => [:goldstar_user_id], :uid_field => :goldstar_user_id if Rails.env.development?
end
```

