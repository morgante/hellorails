class Authorization < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id, :user

  belongs_to :user
  
  validates :provider, :uid, :user_id, :presence => true
  
  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.create_from_auth(auth_hash)
      auth = Authorization.create :user => user,  :provider => auth_hash["provider"], :uid => auth_hash["uid"], :token => auth_hash["credentials"]["token"], :secret => auth_hash["credentials"]["secret"]
    end
    auth
  end
end
