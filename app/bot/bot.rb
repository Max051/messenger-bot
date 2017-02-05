
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'

base_url = 'http://www.wykop.pl/tag/kursyudemy/'

page = Nokogiri::HTML(open(base_url))
page1 =  page.css('li.entry')[0]
page2 =  page1.css('span.text-expanded')
page3 =  page2.css('a')
messages = []
page3.each do |a|
  #a = a.to_s
  if a.values[0].include? "www.udemy.com"
    messages.push(a.text + ' ' + a.values[0])
  end
end

scheduler = Rufus::Scheduler.new

ENV['TZ'] = 'Europe/Berlin'
scheduler.cron '12 22 * * *' do
  messages.each do |text|
  Bot.deliver({
                  recipient:
                      {"id"=>"1359441697464248"},
                  message: {
                      text: text
                  }
              }, access_token: ENV["ACCESS_TOKEN"])
    end
end

Bot.on :message do |message|

  messages.each do |text|
  Bot.deliver({
                  recipient: message.sender,
                  message: {
                      text: text
                  }
              }, access_token: ENV["ACCESS_TOKEN"])
    end
end