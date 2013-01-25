

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '193467880799348', '799b7d4d2b5bb906293cb6a30c405d45'
end

