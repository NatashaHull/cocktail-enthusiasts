# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Topic < ActiveRecord::Base
  attr_accessible :description, :title, :user, :username, :comments

  has_many :votes
  has_many :comments
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :description

  def username
    user.name rescue ""
  end

  def comments?
    comments.length > 0
  end

  def votes_by_user_id(user_id)
    votes.where(:user_id => user_id)
  end
  
  def logged_in_as_author (user_id)
    current_user = User.find(user_id) rescue nil
    user == nil or user == current_user
  end
end
