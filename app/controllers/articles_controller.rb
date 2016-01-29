class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
    
  end
  
  
  def create
    #this will be used to test and render whats in params
    #render plain: params[:article].inspect
    
    #need to whitelist params
    #so create helper method
    @article = Article.new(article_params)
    
    #@article.save
    
    #redirect_to articles_show(@article)
    #redirect_to article_path(@article)
    
    if @article.save
      flash[:notice] = "article saved"
      redirect_to article_path(@article)
    else
      render 'new'
    end
    
  end
  
  def update
    @article = Article.find(params[:id])
  
    if @article.update(article_params)
      flash[:notice] = "article updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
    
  end
  
  
  def show
    @article = Article.find(params[:id])
  end
  
  
  
  
  private 
  def article_params
    params.require(:article).permit(:title, :description )
  end
  
  
end