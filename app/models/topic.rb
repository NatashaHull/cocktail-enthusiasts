class Topic < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :votes
  
  validates_presence_of :title
  
  validates_presence_of :description
  
end