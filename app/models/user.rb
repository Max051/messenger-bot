class User < ApplicationRecord
  validates :facebook_id, presence:true, uniqueness: true
  ActiveRecord::Base.establish_connection('postgres://wrdioimyajmmae:92a7805c4193b16c0a77a4a2cc0ce773d92b5798acc2876802a90fa5062de525@ec2-176-34-111-152.eu-west-1.compute.amazonaws.com:5432/d2t0scao5iojck')
  def self.find_facebook_user(facebook_id)
    self.where(["facebook_id = ?",facebook_id])
  end
end
