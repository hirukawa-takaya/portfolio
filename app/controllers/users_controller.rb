class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @user_topics = Topic.where(user_id: @user).count
    @user_likes =  Like.where(user_id: @user).count
  end
  
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
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
end
