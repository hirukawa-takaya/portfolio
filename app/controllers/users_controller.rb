class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :log_out_user,   only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: '登録成功'
    else
      flash.now[:danger] = "登録失敗"
      render :new
    end
  end
  
  def show
    @user          = User.find(params[:id])
    @user_topics   = Topic.where(user_id: @user).count
    @user_likes    = Like.where(user_id: @user).count
    @user_comments = Comment.where(user_id: @user).count
    @my_topics     = @user.topics.all
    @my_likes      = @user.like_topics
    @my_comments   = @user.comment_topics
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
