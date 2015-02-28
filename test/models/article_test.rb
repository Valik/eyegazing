# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  author     :string(255)
#  subject    :string(255)
#  text       :text
#  question   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
