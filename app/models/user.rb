class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :cover, :styles => { 
      :large => "370x277>",
      :medium => "200x210#",
      :thumb => "80x80#"
    },
  :url  => "/images/users/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/users/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/default-avatar.png',
  :default_style => :thumb
  
  
end
