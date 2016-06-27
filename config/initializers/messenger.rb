# Facebook::Messenger.config.access_token = ''
# #Facebook::Messenger.config.app_secret = 'ab7675a028394c0b225ecc2b158e57b5'
# Facebook::Messenger.config.verify_token = 'this_is_a_verify_token_lalala_123_i_am_fancy'
#
# Facebook::Messenger::Subscriptions.subscribe
#
# # require files
# unless Rails.env.production?
#   Dir["#{Rails.root}/app/bot/**/*.rb"].each { |file| require file }
# end
#

Messenger.configure do |config|
  config.verify_token      = 'MEOWMEOWMEOW' #will be used in webhook verifiction
  config.page_access_token = 'MEOW-MEOW-MEOW'
end