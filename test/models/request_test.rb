# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  age        :integer
#  email      :string(255)
#  party_date :date
#  vk         :string(255)
#  answer     :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
