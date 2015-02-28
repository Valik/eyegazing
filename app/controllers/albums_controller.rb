class AlbumsController < ApplicationController
  respond_to :html

  def photo
    @photos = Photo.paginate( page: params[:page] ).order('created_at DESC').where(photoable_type: 'Photo')
  end

  def video
    @videos = Video.paginate( page: params[:page] ).order('created_at DESC').all_but_main_and_landing
    @video = Video.new if admin_signed_in?
  end

end
