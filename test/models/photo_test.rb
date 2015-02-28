# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  name           :string(255)      default("")
#  photo          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  photoable_id   :integer
#  photoable_type :string(255)
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
