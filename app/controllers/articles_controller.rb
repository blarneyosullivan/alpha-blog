class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def create
    #this will be used to test and render whats in params
    #render plain: params[:article].inspect
    
    #need to whitelist params
    #so create helper method
    @article = Article.new(article_params)
    
    @article.save
    
    redirect_to articles_show(@article)
    
  end
  
  
  
  private 
  def article_params
    params.require(:article).permit(:title, :description )
  end
  
  
end