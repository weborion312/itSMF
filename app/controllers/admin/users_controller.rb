class Admin::UsersController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers
  
  def set_title
    @page_title = "Users Management"
  end
  
  
  def index
    respond_to do |format|
        format.html
        format.json { render json: UsersDatatable.new(view_context) }
    end
  end
  
  def show
    render :action => "index"
  end
  
  def new
    @title = "Add User"
    @user = User.new
  end
  
  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(:url => admin_user_path(@user), :notice => 'Create User Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params.reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_user_path, :notice => 'Update User Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to(admin_users_url)
  end
  
  private
  
  def user_params
    params.require(:user).permit!
  end
end
