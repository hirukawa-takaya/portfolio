class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @topic = Topic.find(params[:topic_id])
    like = Like.new
    like.user_id = current_user.id
    like.topic_id = params[:topic_id]
    like.save
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @like = Like.find_by(topic_id: params[:topic_id], user_id: current_user.id)
    @like.destroy
  end
end