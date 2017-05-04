class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #helper_method :current_user
  before_filter :authenticate, :except => ['show','create','destroy','getconfig']

  def current_user
    if session[:user_id]
      begin
        @current_user = User.find(session[:user_id])
      rescue
        session[:user_id] = nil
        flash[:notice] = "Please Log In First"
        redirect_to "/"
      end
    end
  end

  private
    def authenticate
    if not User.find_by_id(session[:user_id])
      flash[:notice] = "Please Log In First"
      redirect_to "/"
    else
      @current_user = User.find(session[:user_id])
    end
  end
end
