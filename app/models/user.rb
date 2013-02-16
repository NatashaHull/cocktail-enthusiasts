# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :topics, :votes, :comments
  
  has_many :topics
  has_many :votes
  has_many :comments
  
  validates_presence_of :name
end
