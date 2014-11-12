class RegistrationsController < ::Devise::RegistrationsController
  layout "member_sign_up"
  # the rest is inherited, so it should work
  before_filter :load_menu
  
    
  def load_menu
    @menu_parent = Menu.where(parent_id: nil).order(:display_order)  
    @page = Page.where(browser_url: "member-sign-up").first
  end
  
end