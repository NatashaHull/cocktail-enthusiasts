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
  attr_accessible :name, :topics, :votes, :comments, :password, :password_confirmation
  
  has_many :topics
  has_many :votes
  has_many :comments
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 30

  has_secure_password
end
