class TopicsController < ApplicationController
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def new
    @topic = Topic.new
    @like = Like.new
  end
  
  def index
   @topics = Topic.all.includes(:like_users).page(params[:page]).per(8)
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  private
  def topic_params
    params.require(:topic).permit(:image_path, :description, :password)
  end
  
end
