class HomeController < ApplicationController
  def top
    @topics = Topic.all.includes(:like_users).order("created_at DESC")
  end
end
