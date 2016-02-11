class PagesController < ApplicationController
  
  def home
    # if logged in then no need to see this page
    redirect_to articles_path if logged_in?
  end
  
  def about
    
  end
  
end
