class Admin::MembersController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers
  
  def set_title
    @page_title = "Members Management"
  end
  
  
  def index
    respond_to do |format|
        format.html
        format.json { render json: MembersDatatable.new(view_context) }
    end
  end
  
  def show
    render :action => "index"
  end
  
  def new
    @title = "Add Member"
    @member = Member.new
  end
  
  def edit
    @title = "Edit Member"
    @member = Member.find(params[:id])
  end
  
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to(:url => admin_member_path(@member), :notice => 'Create Member Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @member = Member.find(params[:id])
    
    if @member.update_attributes(member_params.reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_member_path, :notice => 'Update Member Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    
    redirect_to(admin_members_url)
  end
  
  private
  
  def member_params
    params.require(:member).permit!
  end
end
