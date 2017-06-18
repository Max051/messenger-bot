require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'
require 'facebook/messenger'
require 'rufus-scheduler'
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token:  'EAAIUZBpo0lB8BAKxnplPebwvs5cSDGWFfHr2LNLBaSYIiJjMIy53q9amIGPzErC80VJv83PlroM25e2evFMio2mZAMchdJkVOBfO94DjaF8uZCJNP8pH8cZBFRxfB7R0Tqx9KJ65SQ2SUcB362kVeFzZAZCtCUWauqjACcXIZAqQQZDZD')

@messages = []
@base_url = 'https://www.wykop.pl/tag/kursyudemy/'
@categories = ["Development","Business","IT & Software", "Office Productivity","Personal Development""Design","Marketing","Lifestyle","Photography","Health & Fitness","Teacher Training","Music","Academics","Language","Test Prep"]
@buttons = [];
def get_messeges(page_with_links)
page = Nokogiri::HTML(open(@base_url))
page1 =  page.css('li.entry')[page_with_links]
page2 =  page1.css('span.text-expanded')
page3 =  page2.css('a')


page3.each do |a|
  if a.values[0].include? "www.udemy.com"
    @messages.push(a.text + ' ' + a.values[0])
  end
end
end



def get_my_messeges(page_with_links)
page = Nokogiri::HTML(open(@base_url))
page1 =  page.css('li.entry')[page_with_links]
page2 =  page1.css('span.text-expanded')
page3 =  page2.css('a')


page3.each do |a|
  if a.values[0].include? "www.udemy.com"
    get_category(a.values[0])
    @messages.push({name: a.text, url:  a.values[0], category:@category})
  end
end

if(@messages == [])
  get_my_messeges(page_with_links += 1)
end
end



def get_category(url)
  cpage = Nokogiri::HTML(open(url))
  cpage1_2 = cpage.css("div.clp-component-render")[2]
  cpage1_3 = cpage.css("div.clp-component-render")[3]
  cpage1_4 = cpage.css("div.clp-component-render")[4]
  begin
  cpage2  =  cpage1_2.xpath('course-category-menu')
  if cpage2.empty?
      cpage2 =  cpage1_3.xpath('course-category-menu')
      if cpage2.empty?
        cpage2 =  cpage1_4.xpath('course-category-menu')
      end
  end
  cpage2_attr =  eval(cpage2.attr('category-data').value)
  @category = cpage2_attr.first[:title]
rescue => e
    puts e.inspect
  end
end
def get_user_categories
  @categories = ["Development","Business","IT & Software", "Office Productivity","Personal Development""Design","Marketing","Lifestyle","Photography","Health & Fitness","Teacher Training","Music","Academics","Language","Test Prep"]
  @users = User.where("facebook_id = ? ",message.sender["id"])
  unless @users.empty?
    @users.first.categories.split(',').each { |user_categorie|
      @categories.delete(user_categorie)
      }
  end
end
def get_buttons
  @categories = ["Development","Business","IT & Software", "Office Productivity","Personal Development","Design","Marketing","Lifestyle","Photography","Health & Fitness","Teacher Training","Music","Academics","Language","Test Prep"]
    @categories.each { |categorie|
      @buttons.push({type: 'postback',title: categorie, payload: categorie})
     }
     @buttons.unshift({type: 'postback',title: 'all', payload: 'all' })

end
def add_category_to_user(new_category)
  @users = User.where("facebook_id = ? ",postback.sender["id"])
  if @users.first.category.nil?
    @users.first.category = new_category
  else
    @users.first.category += ",#{new_category}"
  end
end
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
  @messages = []
  get_messeges(0)
  @messages.unshift("I've got some courses for you")
  @messages.unshift("Hi")
  @messages.push("That's all for now I will send you new courses tommorow")
  @messages.push("If you don't want anymore messages send 'unsubscribe''")
  @messages.push("See you soon")

  @users = User.all

  @users.each do  |user|
    @messages.each do |text|
      begin
      Bot.deliver({
                      recipient:
                          {"id"=>user.facebook_id},
                      message: {
                          text: text
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
      rescue => e
        puts e.inspect
      end
    end
  end
end
def send_my
  @messages = []
  get_my_messeges(0)
    @messages.each do |text|
      Bot.deliver({
                      recipient:
                          {"id"=>'1243697505746313'},
                      message: {
                          text: text[:category]
                      }
                  }, access_token: ENV["ACCESS_TOKEN"])
    end
end

Bot.on :postback do |postback|
  @messages = []
  get_messeges(0)
  @messages.unshift("Hi")
  @messages.push("That's all for now I will send you new courses tommorow")
  @messages.push("If you don't want anymore messages send 'unsubscribe''")

    if postback.payload == "Get Started"
@user = User.create(:facebook_id => postback.sender["id"])
       if @user.valid?
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

  @categories.each { |category|
    if postback.payload == category
      add_category_to_user(category)
      message.reply(
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: 'Would you like to add more categories?',
            buttons:  [{type: 'postback',title: 'Yeah', payload: 'MORE CATEGORIES'},
                      {type: 'postback',title: 'No thanks', payload: 'NO MORE CATEGORIES'}]
          }
        }
      )
    end
    }
    if postback.payload == 'MORE CATEGORIES'
      message.reply(
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: 'What category you like?',
            buttons:[
                  {:type=>"postback", :title=>"all", :payload=>"all"},
                  {:type=>"postback", :title=>"Development", :payload=>"Development"},
                  {:type=>"postback", :title=>"Business", :payload=>"Business"},
                  {:type=>"postback", :title=>"IT & Software", :payload=>"IT & Software"},
                  {:type=>"postback", :title=>"Office Productivity", :payload=>"Office Productivity"},
                  {:type=>"postback", :title=>"Personal Development", :payload=>"Personal Development"},
                  {:type=>"postback", :title=>"Design", :payload=>"Design"},
                  {:type=>"postback", :title=>"Marketing", :payload=>"Marketing"},
                  {:type=>"postback", :title=>"Lifestyle", :payload=>"Lifestyle"},
                  {:type=>"postback", :title=>"Photography", :payload=>"Photography"},
                  {:type=>"postback", :title=>"Health & Fitness", :payload=>"Health & Fitness"},
                  {:type=>"postback", :title=>"Teacher Training", :payload=>"Teacher Training"},
                  {:type=>"postback", :title=>"Music", :payload=>"Music"},
                  {:type=>"postback", :title=>"Academics", :payload=>"Academics"},
                  {:type=>"postback", :title=>"Language", :payload=>"Language"},
                  {:type=>"postback", :title=>"Test Prep", :payload=>"Test Prep"}]
          }
        }
      )
    end
    if postback.payload == 'NO MORE CATEGORIES'
      message.reply(
      text: 'ok'
)
    end

end

Bot.on :message do |message|
  if message.text == "Get Started"

    @user = User.create(:facebook_id => message.sender["id"])
    @messages = []
    get_messeges(0)
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

if message.text == "gib me categories"
#  def get_user_categories
#    @categories = ["Development","Business","IT & Software", "Office Productivity","Personal Development""Design","Marketing","Lifestyle","Photography","Health & Fitness","Teacher Training","Music","Academics","Language","Test Prep"]
#    @users = User.where("facebook_id = ? ",message.sender["id"])
#    unless @users.empty?
#      @users.first.categories.split(',').each { |user_categorie|
#        @categories.delete(user_categorie)
#        }
  #  end
#  end
#  def get_buttons
#get_buttons
puts @buttons
puts "---"
puts @categories

  message.reply(
    attachment: {
         type: 'template',
         payload: {
         template_type: 'button',
         text: 'What category you like?',
         buttons: [
            {:type=>"postback", :title=>"all", :payload=>"all"},
            {:type=>"postback", :title=>"Development", :payload=>"Development"},
            {:type=>"postback", :title=>"Business", :payload=>"Business"},
            {:type=>"postback", :title=>"IT & Software", :payload=>"IT & Software"},
            {:type=>"postback", :title=>"Office Productivity", :payload=>"Office Productivity"},
            {:type=>"postback", :title=>"Personal Development", :payload=>"Personal Development"},
            {:type=>"postback", :title=>"Design", :payload=>"Design"},
            {:type=>"postback", :title=>"Marketing", :payload=>"Marketing"},
            {:type=>"postback", :title=>"Lifestyle", :payload=>"Lifestyle"},
            {:type=>"postback", :title=>"Photography", :payload=>"Photography"},
            {:type=>"postback", :title=>"Health & Fitness", :payload=>"Health & Fitness"},
            {:type=>"postback", :title=>"Teacher Training", :payload=>"Teacher Training"},
            {:type=>"postback", :title=>"Music", :payload=>"Music"},
            {:type=>"postback", :title=>"Academics", :payload=>"Academics"},
            {:type=>"postback", :title=>"Language", :payload=>"Language"},
            {:type=>"postback", :title=>"Test Prep", :payload=>"Test Prep"}
         ]
        }
       }
 )
end



  if message.text.downcase == 'unsubscribe'
    @user = User.where("facebook_id = ? ",message.sender["id"])
  if !@user.empty?
    User.destroy(@user.first.id)
     message.reply(
       text: "I won't send you more messages",
     )
    else
      message.reply(
        text: "You are not subscribed",
      )
    end
end

if message.text == 'help'
    Bot.deliver({
                    recipient: message.sender,
                    message: {
                        text: "Hi I will send you new courses at 20:30 UTC, If you don't wanna anymore messages just send 'unsubscribe'"
                    }
                }, access_token: ENV["ACCESS_TOKEN"])

end

  end
