# Add your own tasks in files placed in lib/tasks ending in .rake,
# for exam
# ple lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require  File.expand_path('../app/bot/bot.rb', 'bot.rb')
require File.expand_path('../app/models/application_record.rb','application_record.rb')
require File.expand_path('../app/models/user.rb','user.rb')
require File.expand_path('../config/application', __FILE__)
require File.expand_path('../config/application.rb','application.rb' )
require File.expand_path('../config/boot.rb','application.rb')
require 'active_record'

Rails.application.load_tasks



task :update do
  send_time
end
