class PhotosController < ApplicationController
  before_action :ensure_signed_in, except: :show

  respond_to :json

  def show
    render json: { photo_url: Photo.find(params[:id]).photo_url }
  end

  def create
    photo, photos = nil, {}
    if params[:photo_form]
      params[:photo_form][:file].each_with_index do |file, indx|
        p = Photo.create(photo: file, photoable_type: 'Photo')
        p_num = 'photo' + indx.to_s
        photos[p_num] = { full: p.photo_url, thumb: p.photo_url(:site, :thumb) }
      end
      render json: { photos: photos }
    elsif params[:file]
      photo = Photo.create( name: params[:hint], photo: params[:file] )
      render json: {
        image: { url: photo.photo_url.split("?")[0] }
      }, content_type: "text/html"
    else
      render json: { status: 'error', status_text: 'При добавлении фото произошла ошибка.' }
    end
  end

  def update
    photo = Photo.find(params[:id])
    if photo.update_attribute :name, params[:name]
      render json: { status: 'success', status_text: 'Фото успешно обновлено.', id: photo.id, name: photo.name }
    else
      render json: { status: 'error', status_text: 'При обновлении фото произошла ошибка.' }
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    if photo.destroy
      render json: { status: 'photo-deleted', status_text: 'Фото успешно удалено.' }
    else
      render json: { status: 'error', status_text: 'При удалении фото произошла ошибка.' }
    end
  end
end
