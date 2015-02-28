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

class Party < ActiveRecord::Base

  validates :name, :description, :date, presence: true
end
