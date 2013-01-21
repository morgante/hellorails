class HomeController < ApplicationController
  def index
    @person = Person.find(1)
    @you = current_user
    
    puts current_user.Twitter
  end
end
