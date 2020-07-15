class TopicsController < ApplicationController
  before_action :logged_in_user   , only: [:new, :create, :destroy]
  before_action :correct_user     , only: :destroy
  before_action :with_password    , only: :show
  before_action :without_password , only: :topic_password
  
  def new
    @topic = Topic.new
    @like = Like.new
    @password = SecureRandom.alphanumeric(6)
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
    @topics = Topic.all.includes(:like_users).page(params[:page]).per(8).order("created_at DESC")
    @user = Topic.find_by(user_id: params[:user_id])
    @q = Topic.ransack(params[:q])
    @results = @q.result(distinct: true).order("created_at DESC")
  end
  
  def topic_password
  end
  
  def authenticate
    topic_id = Topic.find(params[:id])
    if topic_id && topic_id.authenticate(params[:topic][:password])
      redirect_to topic_path(topic_id, :password), success: '成功'
    else
      flash.now[:danger] = '正しいパスワードを入力してください'
      render 'topic_password'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    @comment = Comment.new
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    url = request.url
    if url.include?("topics")
      redirect_to topics_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description, :password)
  end
  
  def correct_user
    @topic = current_user.topics.find_by(id: params[:id])
    redirect_to root_url if @topic.nil?
  end
  
  def with_password
    url = request.url
    @topic = Topic.find(params[:id])
    unless @topic.password_digest.nil? && url.include?("password")
      redirect_to "/topic_password/#{@topic.id}", danger: 'パスワードを入力してください'
    end
  end
  
  def without_password
    @topic = Topic.find(params[:id])
    unless @topic.password_digest
      redirect_to topics_path
    end
  end

end