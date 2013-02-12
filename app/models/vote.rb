# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ip_address :string(255)
#

class Vote < ActiveRecord::Base
  attr_accessible :topic_id, :user
  
  belongs_to :topic
  belongs_to :user
  
  def self.find_by_user(user)
    where(:user => user)
  end
end