require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'
require 'facebook/messenger'
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: 'EAAIUZBpo0lB8BAIjBIotEdw0j4ikZB7S5To4K27MRVnZC7hNGPy3ZBvGwEHQh8v0fWH2eZA6FvTUCLSxzhmhHFga5FudUKZBntO7LKrNQR8KspdS169SvqteaLtMfTeu2rXGHWyEJkYOXjEqyDXMesQ8XMyIxpVTr3KyNIFNs3RwZDZD')


base_url = 'http://www.wykop.pl/tag/kursyudemy/'

page = Nokogiri::HTML(open(base_url))
page1 =  page.css('li.entry')[0]
page2 =  page1.css('span.text-expanded')
page3 =  page2.css('a')
@messages = []
page3.each do |a|
  if a.values[0].include? "www.udemy.com"
    @messages.push(a.text + ' ' + a.values[0])
  end
end

#scheduler = Rufus::Scheduler.new

#ENV['TZ'] = 'Europe/Berlin'
#scheduler.cron '12 22 * * *' do


Facebook::Messenger::Thread.set({
                                    setting_type: 'call_to_actions',
                                    thread_state: 'new_thread',
                                    call_to_actions: [
                                        {
                                            payload: 'Get Started'
                                        }
                                    ]
                                }, access_token: ENV['ACCESS_TOKEN'])



def send_time
  @messages.each do |text|
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

  if message.text == "Get Started"

    Bot.deliver({
                    recipient: message.sender,
                    message: {
                        text: 'Welcome to my Bot here are latest free Udemy Courses'
                    }
                }, access_token: ENV["ACCESS_TOKEN"])
    messages.each do |text|
      Bot.deliver({
                      recipient: message.sender,
                      message: {
                          text: text
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end

  end
end

#  messages.each do |text|
#  Bot.deliver({
#                  recipient: message.sender,
#                  message: {
#                      text: text
#                  }
#              }, access_token: ENV["ACCESS_TOKEN"])
#    end
#end
