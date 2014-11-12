class SessionsController < ::Devise::SessionsController
  layout "member_sign_in"
  # the rest is inherited, so it should work
  before_filter :load_menu
  
    
  def load_menu
    @menu_parent = Menu.where(parent_id: nil).order(:display_order)  
    @page = Page.find(26)
  end
  
end