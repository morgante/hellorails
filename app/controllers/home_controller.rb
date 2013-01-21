class HomeController < ApplicationController
  def index
    @person = Person.find(1)
    @you = current_user
    
    # @message = current_user.Twitter.update("This is a tweet from my client.")
  end
end
