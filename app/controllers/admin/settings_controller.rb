class Admin::SettingsController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Settings Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: SettingsDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Setting"
    @setting = Setting.new
  end

  def edit
    @title = "Edit Setting"
    @setting = Setting.find(params[:id])
  end

  def create
    @setting = Setting.new(setting_params)
    if @setting.save
      redirect_to(:url => admin_setting_path(@setting), :notice => 'Create Setting Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @setting = Setting.find(params[:id])
  
    if @setting.update_attributes(setting_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_setting_path, :notice => 'Update Setting Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
  
    redirect_to(admin_settings_url)
  end

  private

  def setting_params
    params.require(:setting).permit!
  end    
end
