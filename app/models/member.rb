class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable
  has_attached_file :cover, :styles => { 
      :large => "370x277>",
      :medium => "200x210#",
      :thumb => "80x80#"
    },
  :url  => "/images/members/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/members/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/banner-noimg.png',
  :default_style => :thumb
  
         
         
end
