class PagesController < ApplicationController
  before_filter :load_menu
  
    
  def load_menu
    @menu_parent = Menu.where(parent_id: nil).order(:display_order)  
  end
  
  def index
    #@banners = Media.tagged_with("home_banner")
    #@articles = Article.where(status: 1).order("publish_date DESC").limit(5)
    
    @page = Page.where(browser_url: 'home').first
    @page_component = PageComponent.where(page_id: @page.id)
    render :layout => @page.designed_template.name
  end
  
  def show
    @page = Page.where(browser_url: params[:browser_url]).first
    @page_component = PageComponent.where(page_id: @page.id)
    
    #Load parent
    @pm = Menu.find(Menu.where(page_id: @page.id).first.parent_id) 

    render :layout => @page.designed_template.name
    
  end
  
  def show_article
    @page = Article.find(params[:id])
    
    render :layout => @page.designed_template.name
  end
  
  def show_event
    @page = Event.find(params[:id])
    
    render :layout => @page.designed_template.name
  end
  
end
