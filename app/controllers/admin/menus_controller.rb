class Admin::MenusController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers
  
   skip_before_filter :verify_authenticity_token  
  
  def set_title
    @page_title = "Menu Management"
  end
  
  
  def index
    @menu_parent = Menu.where(parent_id: nil).order(:display_order)
    #@menu_sub = Menu.order(:display_order)
  end
  
  
  def update_menu
    menus_array = ActiveSupport::JSON.decode(params[:menus])
    parse_categories(menus_array, nil)
    
    if params[:id] != '0'
      @menu = Menu.find(params[:id])
      @menu.update_attributes(is_clickable: params[:value])
    end
    #for m in params[:menus]
      #Menu.find_or_create_by(page_id: m["0"][:id].to_i) do |c|
      #  c.display_order = m["0"].to_i
      #end
    #  logger.info(m.id)
    #end
    render :json => true
  end
  
  protected
    def parse_categories(menus_array, parent)
      menus_array.each_with_index do |category_hash, position|
        if category_hash["id"] != 0
          menu = Menu.find_or_create_by(page_id: category_hash["id"])
          menu.update_attributes(display_order: position, parent_id: parent)
          parse_categories(category_hash["children"], menu.id) if category_hash["children"]
        end
      end
    end
  
end
