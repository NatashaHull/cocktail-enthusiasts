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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
