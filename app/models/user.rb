class User < ApplicationRecord
  validates :facebook_id, presence:true, uniqueness: true

  def self.find_facebook_user(facebook_id)
    self.where(["facebook_id = ?",facebook_id])
  end
end
