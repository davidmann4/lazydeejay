# Facebook::Messenger.config.access_token = ''
# #Facebook::Messenger.config.app_secret = ''
# Facebook::Messenger.config.verify_token = ''
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
