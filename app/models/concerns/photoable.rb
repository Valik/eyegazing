module Photoable

  extend ActiveSupport::Concern

  included do
    mount_uploader :photo, PhotoUploader

    after_commit :remove_photo!, on: :destroy

    validates :photo, presence: true
  end

end

