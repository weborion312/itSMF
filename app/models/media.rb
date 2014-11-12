class Media < ActiveRecord::Base
  acts_as_taggable
  
  has_attached_file :item,:styles => { 
      :large => "1920x714#",
      :thumb => "272x150#"
    },
  :url  => "/media_upload/:id/:style/:basename.:extension",
  :path => ":rails_root/public/media_upload/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/banner-noimg.png',
  :default_style => :thumb
  
  before_post_process :skip_for_video

  def skip_for_video
    ! %w(video/quicktime video/mp4 video/wmv).include?(item_content_type)
  end
  
end
