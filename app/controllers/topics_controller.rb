class TopicsController < ApplicationController
  
  def new
    @topic = Topic.new
    @like = Like.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def index
    @topics = Topic.all.includes(:like_users).page(params[:page]).per(8)
  end
  
  def topic_password
  end
  
  def authenticate
    topic_id = Topic.find(params[:id])
    if topic_id && topic_id.authenticate(params[:topic][:password])
      redirect_to topic_path(topic_id), success: '成功'
    else
      flash.now[:danger] = '正しいパスワードを入力してください'
      render 'topic_password'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  private
  def topic_params
    params.require(:topic).permit(:image_path, :description, :password)
  end

end