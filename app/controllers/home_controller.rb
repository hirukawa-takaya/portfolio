class HomeController < ApplicationController
  def top
  end
  
  def index
    @users = User.all
  end
end
