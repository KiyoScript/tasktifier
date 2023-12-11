Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], :scope => "email, profile",
    :provider_ignores_state => true,
    redirect_uri: "#{ENV["APP_HOST"]}/auth/google_oauth2/callback"
end
OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true
