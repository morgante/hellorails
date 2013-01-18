class HomeController < ApplicationController
  def index
    @person = Person.find(1)
    @you = current_user
  end
end
