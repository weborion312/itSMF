class Admin::LocalesController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Locales Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: LocalesDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Locale"
    @locale = Locale.new
  end

  def edit
    @title = "Edit Locale"
    @locale = Locale.find(params[:id])
  end

  def create
    @locale = Locale.new(locale_params)
    if @locale.save
      redirect_to(:url => admin_locale_path(@locale), :notice => 'Create Locale Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @locale = Locale.find(params[:id])
  
    if @locale.update_attributes(locale_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_locale_path, :notice => 'Update Locale Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @locale = Locale.find(params[:id])
    @locale.destroy
  
    redirect_to(admin_locales_url)
  end

  private

  def locale_params
    params.require(:locale).permit!
  end
end
