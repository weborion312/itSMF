class DesignedTemplate < ActiveRecord::Base
  has_many :pages
  has_many :articles
  has_many :events
  
  has_attached_file :item,
  :url  => "/template_update/:id/:style/:basename.:extension",
  :path => ":rails_root/public/template_update/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/banner-noimg.png',
  :default_style => :thumb

end
