class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
  
   # render 'new'
   #debugger
   
   user = User.find_by(email: params[:session][:email].downcase)
   
   # check if user is not null
   # and user authenticates using params password
   if user && user.authenticate(params[:session][:password])
     # save id for session
     session[:user_id] = user.id
     flash[:success] = "You have logged in"
     # send to users show page
     redirect_to user_path(user)
   else
     # this is not a user backed form so no flash messages
     # flash persists for one request
     flash.now[:danger] = "There was problems with your login details "
     render 'new'
   end
   
  end
  
  
  def destroy
    session[:user_id] = nil
    flash[:success] = " logged out"
    
    redirect_to root_path
  end
  
  
end