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

class Request < ActiveRecord::Base

  validates :name, :age, :email, :party_date, presence: true

  has_one :photo, class_name: 'RequestPhoto', dependent: :destroy
end
