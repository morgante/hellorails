class HomeController < ApplicationController
  def index
    @person = Person.find(1)
    @you = current_user
    
    @message = current_user.Facebook.get_connections("me", "friends").length
  end
end
