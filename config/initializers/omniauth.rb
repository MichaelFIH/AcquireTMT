# Google sign-in. Set GOOGLE_CLIENT_ID / GOOGLE_CLIENT_SECRET (see .env.example).
# Until they're set, the button renders but the handshake will fail.
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV["GOOGLE_CLIENT_ID"],
           ENV["GOOGLE_CLIENT_SECRET"],
           scope: "email,profile"
end

OmniAuth.config.allowed_request_methods = [:post]
OmniAuth.config.silence_get_warning = true
