class UsersController < ApplicationController
  
  # this will set user before these methods
  before_action :set_user, only: [:edit, :update, :show]

  before_action :require_same_user1, only: [:edit, :update]
  
  
  def index
    #@users = User.all     
    @users = User.paginate(page: params[:page], per_page: 5)

  end
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Welcome to alpha blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'  
    end
    
  end

  def edit

  end
  
  def update

    if @user.update(user_params)
      flash[:success] = "account updated"
      redirect_to articles_path
      
    else
      render 'edit'
    end
    
  end
  
  
  def show
  
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)

  end 





  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user1
    if current_user != @user
      flash[:danger] = "you can only update your own account"
      redirect_to root_path
    end
  end

end
