class Admin::SessionsController < ::Devise::SessionsController
  layout "admin_sign_in"
  # the rest is inherited, so it should work
end