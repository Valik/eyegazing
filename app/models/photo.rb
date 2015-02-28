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

class Photo < ActiveRecord::Base
  include Photoable
  belongs_to :photoable, polymorphic: true

  self.per_page = 24

  def photo_type?( kind )
    case kind
    when 'request' then nil
    when 'site' then true
    end
  end

end
