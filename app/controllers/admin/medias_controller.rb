class Admin::MediasController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Medias Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: MediasDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Media"
    @media = Media.new
  end

  def edit
    @title = "Edit Media"
    @media = Media.find(params[:id])
  end

  def create
    @media = Media.new(media_params)
    if @media.save
      redirect_to(:url => admin_media_path(@media), :notice => 'Create Media Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @media = Media.find(params[:id])
  
    if @media.update_attributes(media_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_media_path, :notice => 'Update Media Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @media = Media.find(params[:id])
    @media.destroy
  
    redirect_to(admin_medias_url)
  end

  private

  def media_params
    params.require(:media).permit!
  end
end
