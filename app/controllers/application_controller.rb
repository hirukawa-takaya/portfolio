class ApplicationController < ActionController::Base
  # 例外処理
rescue_from ActiveRecord::RecordNotFound, with: :render_404
rescue_from ActionController::RoutingError, with: :render_404
# rescue_from Exception, with: :render_500

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/error_404", status: 404, layout: 'application'
  end

# def render_500
#   render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
# end
  
  
  protect_from_forgery with: :exception
  
  add_flash_types :success, :info, :warning, :danger
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_in(user)
      session[:user_id] = user.id
  end
    
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  def log_out_user
    if logged_in?
      flash[:danger] = "ログイン済です"
      redirect_to root_path
    end
  end
end
