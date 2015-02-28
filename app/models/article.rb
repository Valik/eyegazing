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

class Article < ActiveRecord::Base
  validates :subject, presence: true

  self.per_page = 5
end
