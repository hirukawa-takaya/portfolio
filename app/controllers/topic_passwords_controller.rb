class TopicPasswordsController < ApplicationController
  def new
  end
  
  def create
    topic = Topic.find_by(id: params[:topic_passwords][:id])
    if topic && topic.authenticate(params[:topic_passwords][:password])
      can_be_viewed(topic)
      redirect_to topic_path(current_viewer)
    else
      render 'new'
    end
  end
  
  private
  
  def can_be_viewed(topic)
    session[:id] = Topic.ids
  end
  
  def current_viewer
    @current_viewer ||= Topic.find_by(id: session[:id])
  end
  
end
