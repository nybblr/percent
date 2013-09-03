OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  ENDPOINT = "http://localhost:5000"

  provider :developer unless Rails.env.development?
  provider :stable, ENV['STABLE_APP_ID'], ENV['STABLE_APP_SECRET'],
    client_options: { site: ENDPOINT }
end
