class RequestPhoto < ActiveRecord::Base
  include Photoable
  belongs_to :request

  def photo_type?( kind )
    case kind
    when 'request' then true
    when 'site' then nil
    end
  end

end
