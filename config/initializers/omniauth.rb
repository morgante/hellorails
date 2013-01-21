Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'F33v0Lp4ZWVowwmkyQT4MQ', 'HSMY5GLcIeOMmbFfk5FAA1b94R361eO8XMikamTyEI'
  provider :facebook, '575294275830121', '8e70d8aee55169b0a4276a9bdf5c2d8b'
end