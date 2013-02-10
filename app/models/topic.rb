# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :votes
  
  validates_presence_of :title
  
  validates_presence_of :description
  
end
