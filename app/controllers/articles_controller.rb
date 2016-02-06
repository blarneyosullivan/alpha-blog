class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]
    
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    #@article = Article.find(params[:id])
    
  end
  
  
  def create
    #this will be used to test and render whats in params
    #render plain: params[:article].inspect
    
    #need to whitelist params
    #so create helper method
    
    #debugger
    @article = Article.new(article_params)
    @article.user = User.first
    #@article.save
    
    #redirect_to articles_show(@article)
    #redirect_to article_path(@article)
    
    if @article.save
      flash[:success] = "article saved"
      redirect_to article_path(@article)
    else
      render 'new'
    end
    
  end
  
  def update
    #@article = Article.find(params[:id])
  
    if @article.update(article_params)
      flash[:success] = "article updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
    
  end
  
  
  def show
    #@article = Article.find(params[:id])
  end
  
  def destroy
    #@article = Article.find(params[:id])
    
    @article.destroy
    flash[:danger] = "article deleted"
    
    redirect_to articles_path
  end
  
  
  
  private 
    def article_params
      params.require(:article).permit(:title, :description )
    end
  
    def set_article
      @article = Article.find(params[:id])
    end
  
end