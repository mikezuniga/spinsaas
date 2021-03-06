Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    scope: ['https://mail.google.com/','contacts','plus.login','plus.me','userinfo.email','userinfo.profile'], image_aspect_ratio: 'square', image_size: 48, access_type: 'online'
}
end
