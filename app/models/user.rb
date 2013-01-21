class User < ActiveRecord::Base
  has_many :authorizations
  accepts_nested_attributes_for :authorizations
  
  attr_accessible :name, :email
  validates :name, :presence => true
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end
  
  def self.create_from_auth(auth)
    create! do |user|
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end
  
  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"], :token => auth_hash["credentials"]["token"]
    end
  end
  
  def has_auth_with( provider )
    provider
  end
  
  def Twitter
    self.has_auth_with( provider )
  end
  
end

# class TwitterWrapper
#    attr_reader :tokens
#    
#    def initialize(config, user)
#      @config = config
#      @tokens = YAML::load_file @config
#      @callback_url = @tokens['callback_urls'][Rails.env]
#      @auth = Twitter::OAuth.new @tokens['consumer_token'], @tokens['consumer_secret']
#      @user = user
#    end
#    
#    def request_tokens
#      rtoken = @auth.request_token :oauth_callback => @callback_url
#      [rtoken.token, rtoken.secret]
#    end
#    
#    def authorize_url
#      @auth.request_token(:oauth_callback => @callback_url).authorize_url
#    end
#    
#    def auth(rtoken, rsecret, verifier)
#      @auth.authorize_from_request(rtoken, rsecret, verifier)
#      @user.access_token, @user.access_secret = @auth.access_token.token, @auth.access_token.secret
#      @user.save
#    end
#    
#    def get_twitter
#      @auth.authorize_from_access(@user.access_token, @user.access_secret)
#      twitter = Twitter::Base.new @auth
#      twitter.home_timeline(:count => 1)
#      twitter
#    end
#  end