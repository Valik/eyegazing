# == Schema Information
#
# Table name: recalls
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  text         :text
#  published    :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  published_at :datetime
#

require 'test_helper'

class RecallTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
