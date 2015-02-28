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

class Page < ActiveRecord::Base
end
