class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy
  before_action :log_out_user,   only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログイン失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, success: 'ログアウトしました'
  end
  
  private
    def log_in(user)
      session[:user_id] = user.id
    end
    
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
  
end
