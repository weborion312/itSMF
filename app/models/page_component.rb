class PageComponent < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :page
end
