# Add your own tasks in files placed in lib/tasks ending in .rake,
# for exam
# ple lib/tasks/capistrano.rake, and they will automatically be available to Rake.
#require 'app/bot/bot.rb'

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks



task :update do
  @messages.each do |text|
    Bot.deliver({
                    recipient:
                        {"id"=>"1359441697464248"},
                    message: {
                        text: text
                    }
                }, access_token: ENV["ACCESS_TOKEN"])
end
