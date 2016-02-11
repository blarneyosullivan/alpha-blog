class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  # by default these methods are available to controllers not views
  
  # this will make these methods available to views
  helper_method :current_user, :logged_in?
  
  
  def current_user
    # this searches database for user match to session user
    # if found it returns user object for user
    # if current user already got from database then nothing to do
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #boolean
    # returns true if have current_user else false
    !!current_user
  end
  
  def require_user
    
    if !logged_in?
      flash[:danger] = " you must be logged in to perform that action"
      redirect_to root_path
    end
    
  end
  
  def require_same_user
    
    if current_user != @article.user
      flash[:danger] = " you can only update your own articles"
      redirect_to root_path
    end
    
  end
  
  
end
