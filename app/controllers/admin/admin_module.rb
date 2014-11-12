module Admin::AdminModule

  #include Devise::Controllers::Helpers
  
  def self.included(base)
    base.before_filter :authenticate_admin_user!
    
    base.layout "admin"
    I18n.default_locale = :en
  end
  
  
  def set_en_locale
    I18n.default_locale = :en
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