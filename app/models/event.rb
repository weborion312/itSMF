class Event < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :designed_template
  
  has_attached_file :cover, :styles => { 
      :large => "848x352#",
      :medium => "500x277>",
      :thumb => "272x150#"
    },
  :url  => "/images/articles/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/articles/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/banner-noimg.png',
  :default_style => :thumb
  
  before_post_process :transliterate_file_name
  
  def transliterate_file_name
    extension = File.extname(cover.original_filename).gsub(/^\.+/, '')
    filename = cover.original_filename.gsub(/\.#{extension}$/, '')
    self.cover.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
  end
  
  def transliterate(str)
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    s.downcase!
    s.gsub!(/'/, '')
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
    s.strip!
    s.gsub!(/\ +/, '-')
    return s
  end

end
