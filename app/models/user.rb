class User < ApplicationRecord

  validates :facebook_id, presence:true, uniqueness: true
  ActiveRecord::Base.establish_connection(ENV["DATABASE_HEROKU_URL"])

end
