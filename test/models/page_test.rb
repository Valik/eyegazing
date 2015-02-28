# == Schema Information
#
# Table name: pages
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("")
#  title         :string(255)      default("")
#  content       :text             default("")
#  ps            :text             default("")
#  sidebar_title :string(255)      default("")
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
