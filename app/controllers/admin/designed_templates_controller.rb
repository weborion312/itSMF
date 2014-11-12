class Admin::DesignedTemplatesController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Templates Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: TemplatesDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Template"
    @designed_template = DesignedTemplate.new
  end

  def edit
    @title = "Edit Template"
    @designed_template = DesignedTemplate.find(params[:id])
  end

  def create
    @designed_template = DesignedTemplate.new(designed_template_params)
    if @designed_template.save
      redirect_to(:url => admin_designed_template_path(@designed_template), :notice => 'Create Template Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @designed_template = DesignedTemplate.find(params[:id])
  
    if @designed_template.update_attributes(designed_template_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_designed_template_path, :notice => 'Update Template Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @designed_template = DesignedTemplate.find(params[:id])
    @designed_template.destroy
  
    redirect_to(admin_designed_templates_url)
  end

  private

  def designed_template_params
    params.require(:designed_template).permit!
  end
end
