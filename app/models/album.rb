# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  kind       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  has_many :photos
  has_many :videos

  validates :name, presence: true

  mount_uploader :photo, PhotoUploader
end
