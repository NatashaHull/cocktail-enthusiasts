class Topic < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :votes
end