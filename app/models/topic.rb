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
  attr_accessible :description, :title, :user, :username

  has_many :votes
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :description

  def username
    if user
      user.name
    else
      ""
    end
  end

  def votes_by_user_id(user_id)
    votes.where(:user_id => user_id)
  end
end
