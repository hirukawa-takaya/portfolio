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
    @user = Topic.find_by(user_id: params[:user_id])
    @q = Topic.ransack(params[:q])
    
    if params[:option] == "new" || params[:option] == nil
      @topics = @q.result(distinct: true).order("created_at DESC").page(params[:page]).per(8)
    elsif params[:option] == "new"
      @topics = @q.result(distinct: true).order("created_at DESC").page(params[:page]).per(8)
    elsif params[:option] == "old"
      @topics = @q.result(distinct: true).order("created_at ASC").page(params[:page]).per(8)
    elsif params[:option] == "like_most"
      @topics = Kaminari.paginate_array(@q.result.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')).page(params[:page]).per(8)
    end
    
  end
  
  def topic_password
  end
  
  def authenticate
    topic = Topic.find(params[:id])
    if topic && topic.authenticate(params[:topic][:password])
      redirect_to topic_path(topic, parameter: topic.password_digest), success: '成功'
    else
      flash.now[:danger] = '正しいパスワードを入力してください'
      render 'topic_password'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments
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
    params.require(:topic).permit(:image, :description, :password, :parameter)
  end
  
  def correct_user
    @topic = current_user.topics.find_by(id: params[:id])
    redirect_to root_url if @topic.nil?
  end
  
  def with_password
    url = request.url.gsub!(/%21|%22|%23|%24|%24|%25|%26|%27|%28|%29|%2A|%2B|%2C|%2F|%3A|%3B|%3C|%3D|%3E|%3F|%40|%5B|%5D|%5E|%60|%7B|%7C|%7D|%7E|/,
    "%21" => "!", "%22" => '"', "%23" => "#", "%24" => "$", "%25" => "%", "%26" => "&", "%27" => "'", "%28" => "(", "%29" => ")",
    "%2A" => "*", "%2B" => "+", "%2C" => ",", "%2F" => "/", "%3A" => ":", "%3B" => ";", "%3C" => "<", "%3D" => "=", "%3E" => ">", "%3F" => "?", "%40" => "@",
    "%5B" => "[", "%5D" => "]", "%5E" => "^", "%60" => "`", "%7B" => "{", "%7C" => "|", "%7D" => "}", "%7E" => "~")
    @topic = Topic.find(params[:id])
    if !@topic.password_digest.nil? && !url.try(:include?, @topic.password_digest)
      redirect_to "/topic_password/#{@topic.id}", danger: 'パスワードを入力してください'
    end
  end
  
  def without_password
    @topic = Topic.find(params[:id])
    if @topic.password_digest.nil?
      redirect_to topics_path
    end
  end

end