require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'
require 'facebook/messenger'
require 'rufus-scheduler'
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token:  'EAAIUZBpo0lB8BAKxnplPebwvs5cSDGWFfHr2LNLBaSYIiJjMIy53q9amIGPzErC80VJv83PlroM25e2evFMio2mZAMchdJkVOBfO94DjaF8uZCJNP8pH8cZBFRxfB7R0Tqx9KJ65SQ2SUcB362kVeFzZAZCtCUWauqjACcXIZAqQQZDZD')


@base_url = 'http://www.wykop.pl/tag/kursyudemy/'
def get_messeges(page_with_links)
page = Nokogiri::HTML(open(@base_url))
page1 =  page.css('li.entry')[page_with_links]
page2 =  page1.css('span.text-expanded')
page3 =  page2.css('a')
@messages = []

page3.each do |a|
  if a.values[0].include? "www.udemy.com"
    @messages.push(a.text + ' ' + a.values[0])
  end
end
if(@messages == [])
  get_messeges(page_with_links += 1)
end
end

get_messeges(0)

Facebook::Messenger::Thread.set({
                                    setting_type: 'call_to_actions',
                                    thread_state: 'new_thread',
                                    call_to_actions: [
                                        {
                                            payload: 'Get Started'
                                        }
                                    ]
                                }, access_token:  'EAAIUZBpo0lB8BAKxnplPebwvs5cSDGWFfHr2LNLBaSYIiJjMIy53q9amIGPzErC80VJv83PlroM25e2evFMio2mZAMchdJkVOBfO94DjaF8uZCJNP8pH8cZBFRxfB7R0Tqx9KJ65SQ2SUcB362kVeFzZAZCtCUWauqjACcXIZAqQQZDZD' )



def send_time
  @messages.unshift("I've got some courses for you")
  @messages.unshift("Hi")
  @messages.push("That's all for now I will send you new courses tommorow")
  @messages.push("If you don't want anymore messages send 'unsubscribe''")
  @messages.push("See you soon")

  @users = User.all

  @users.each do  |user|
    @messages.each do |text|
      Bot.deliver({
                      recipient:
                          {"id"=>user.facebook_id},
                      message: {
                          text: text
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end
  end
end
def send_time_over34
  @messages.unshift("I've got some courses for you")
  @messages.unshift("Hi")
  @messages.push("That's all for now I will send you new courses tommorow")
  @messages.push("If you don't want anymore messages send 'unsubscribe''")
  @messages.push("See you soon")



  User.all.each do  |user|
    if user.id > 33


    @messages.each do |text|
      Bot.deliver({
                      recipient:
                          {"id"=>user.facebook_id},
                      message: {
                          text: text
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
                end
              else
                @messages = [];
    end
  end
end
def send_my
  @user = User.first
    @messages.each do |text|
      Bot.deliver({
                      recipient:
                          {"id"=>'100000992779105'},
                      message: {
                          text: text
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end
end

Bot.on :postback do |postback|

    if postback.payload == "Get Started"

      @user = User.create(:facebook_id => postback.sender["id"])
       if @user.valid?
          @messages.unshift('Welcome to my Bot here are latest free Udemy Courses')
          @messages.push("That's all for now I will send you new courses at 20:30 UTC")
          @messages.push("If you don't want anymore messages send 'unsubscribe''")
          @messages.each do |text|
          Bot.deliver({
                          recipient: postback.sender,
                          message: {
                              text: text
                          }
                      }, access_token: ENV["ACCESS_TOKEN"])
        end
       else
        Bot.deliver({
                        recipient: postback.sender,
                        message: {
                            text: 'You already subscribed or something went wrong'
                        }
                    }, access_token: ENV["ACCESS_TOKEN"])
      end
  end
end
Bot.on :message do |message|
  if message.text == "Get Started"

    @user = User.create(:facebook_id => message.sender["id"])

    if @user.valid?
      @messages.unshift('Welcome to my Bot here are latest free Udemy Courses')
      @messages.push("That's all for now I will send you new courses at 20:30 UTC")
      @messages.push("If you don't want anymore messages send 'unsubscribe''")
      @messages.each do |text|
        Bot.deliver({
                        recipient: message.sender,
                        message: {
                            text: text
                        }
                    }, access_token: ENV["ACCESS_TOKEN"])
      end
    else
      Bot.deliver({
                      recipient: message.sender,
                      message: {
                          text: 'You already subscribed or something went wrong'
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end
end

  if message.text.downcase == 'unsubscribe'
    @user = User.find_facebook_user(message.sender["id"])
    if !@user.empty?
     @user.destroy(@user.ids)
      Bot.deliver({
                      recipient: message.sender,
                      message: {
                          text: "I won't send you more messages"
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    else

      Bot.deliver({
                      recipient: message.sender,
                      message: {
                          text: 'You are not  subscribed or something went wrong'
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end
end

if message.text.downcase == 'help'
    Bot.deliver({
                    recipient: message.sender,
                    message: {
                        text: "Hi I will send you new courses at 20:30 UTC, If you don't wanna anymore messages just send 'unsubscribe'"
                    }
                }, access_token: ENV["ACCESS_TOKEN"])

end


  end
