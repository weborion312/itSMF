class Page < ActiveRecord::Base
  acts_as_taggable
  
  has_many :menus, :dependent => :destroy
  has_many :page_components, :dependent => :destroy
  has_many :extra_texts, :dependent => :destroy
  belongs_to :designed_template
  
  accepts_nested_attributes_for :extra_texts
end
