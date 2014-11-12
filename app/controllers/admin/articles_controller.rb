class Admin::ArticlesController < ApplicationController
    include Admin::AdminModule
    before_filter :set_title
    include Devise::Controllers::Helpers
  
    def set_title
      @page_title = "Articles Management"
    end
  
  
    def index
      respond_to do |format|
          format.html
          format.json { render json: ArticlesDatatable.new(view_context) }
      end
    end
  
    def show
      render :action => "index"
    end
  
    def new
      @title = "Add Article"
      @article = Article.new
    end
  
    def edit
      @title = "Edit Article"
      @article = Article.find(params[:id])
    end
  
    def create
      @article = Article.new(article_params)
      @article.browser_title = @article.title
      @article.browser_url = transliterate(@article.title)
      
      if @article.save
        redirect_to(:url => admin_article_path(@article), :notice => 'Create Article Successfully!')
      else
        render :action => "new"
      end
    end
  
    def update
      @article = Article.find(params[:id])
      @article.browser_title = @article.title
      @article.browser_url = transliterate(@article.title)
    
      if @article.update_attributes(article_params.reject{|k,v| v.blank?})
      
        redirect_to(:url => admin_article_path, :notice => 'Update Article Successfully!')
      else
        render :action => "edit"
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
    
      redirect_to(admin_articles_url)
    end
  
    private
  
    def article_params
      params.require(:article).permit!
    end
  end
