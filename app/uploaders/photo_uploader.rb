# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # process :resize_to_fit => [1920, 1920]

  version :site, :if => :is_site_photo?

  version :site do

    version :main do
      process :resize_to_fill => [660, 372]
    end

    version :album_thumb do
      process :resize_to_fill => [300, 225]
    end

    version :sidebar, :from_version => :album_thumb do
      process :resize_to_fill => [230, 150]
    end

    version :thumb, :from_version => :album_thumb do
      process :resize_to_fill => [146, 146]
    end

  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def self.fog_public
  #   true
  # end

  protected

    def is_request?( photo )
      model.photo_type?('request')
    end

    def is_site_photo?( photo )
      model.photo_type?('site')
    end

  #   def is_photo? picture
  #     model.photo_type == 'Photo'
  #   end

  #   def is_video? picture
  #     raise params.inspect
  #     model.photo_type == 'Video'
  #   end

end
