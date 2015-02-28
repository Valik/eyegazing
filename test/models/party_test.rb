# == Schema Information
#
# Table name: parties
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  address     :string(255)
#  ps          :text
#  date        :date
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class PartyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
