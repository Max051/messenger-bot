class User < ApplicationRecord
  validates :facebook_id, presence:true, uniqueness: true
  ActiveRecord::Base.establish_connection(ENV["DATABASE_HEROKU_URL"])
  def self.find_facebook_user(facebook_id)
    self.where(["facebook_id = ?",facebook_id])
  end
end
