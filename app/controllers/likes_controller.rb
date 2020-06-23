class LikesController < ApplicationController
    
def index
  @like_topics = current_user.like_topics.page(params[:page]).per(8)
end
    
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