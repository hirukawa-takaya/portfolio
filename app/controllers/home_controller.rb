class HomeController < ApplicationController
  def top
    @topics = Topic.all.includes(:like_users).order("created_at DESC")
    @user = Topic.find_by(user_id: params[:user_id])
  end
  
  def index
    @users = User.all
  end
end
