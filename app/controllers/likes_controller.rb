class LikesController < ApplicationController
    
def index
  @like_topics = current_user.like_topics.page(params[:page]).per(8)
end
    
def create
    like = Like.new
    like.user_id = current_user.id
    like.topic_id = params[:topic_id]

    if like.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りに登録に失敗しました'
    end
end

def destroy
    @like = Like.find_by(topic_id: params[:topic_id], user_id: current_user.id)
    @like.destroy
    redirect_to topics_path, success: 'お気に入りを解除しました'
end


end