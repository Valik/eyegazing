# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  link       :string(255)
#  name       :string(255)
#  video_main :boolean
#  created_at :datetime
#  updated_at :datetime
#  landing    :boolean          default(FALSE)
#

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
