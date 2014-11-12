class Admin::PagesController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Pages Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: PagesDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Page"
    @page = Page.new
  end

  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])
    
    session[:page_id] = params[:id]
    @all_components = PageComponent.where(page_id: params[:id]).paginate(:page => params[:page])
    
    @component = PageComponent.new
  end

  def create
    @page = Page.new(page_params)
    @page.browser_title = @page.title
    @page.browser_url = transliterate(@page.title)
    if @page.save
      redirect_to(:url => admin_page_path(@page), :notice => 'Create Page Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.browser_title = @page.title
    @page.browser_url = transliterate(@page.title)
    if @page.update_attributes(page_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_page_path, :notice => 'Update Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
  
    redirect_to(admin_pages_url)
  end
  
  def create_page_component
    @component = PageComponent.new(page_component_params)
    @component.page_id = session[:page_id]
    @component.save
    
    @title = "Edit Page"
    @page = Page.find(session[:page_id])

    @all_components = PageComponent.where(page_id: session[:page_id]).paginate(:page => params[:page])
    
    @component = PageComponent.new
    
    render :action => "edit"
  end
  
  def destroy_page_component
    @component = PageComponent.find(params[:id])
    @component.destroy
    
    @title = "Edit Page"
    @page = Page.find(session[:page_id])

    @all_components = PageComponent.where(page_id: session[:page_id]).paginate(:page => params[:page])
    
    @component = PageComponent.new
    
    render :action => "edit"
  end

  private

  def page_params
    params.require(:page).permit!
  end
  
  def page_component_params
    params.require(:component).permit!
  end
end
