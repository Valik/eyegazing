class VideosController < ApplicationController
  include AutoHtml

  before_action :ensure_signed_in, except: :show
  skip_before_filter :verify_authenticity_token, only: :create

  respond_to :json, except: :edit
  respond_to :edit, only: :edit

  def create
    video_link_backup = params[:video][:link].dup
    if video_params[:link].match(/youtu/)
      params[:video][:link] = auto_html(video_params[:link]){ youtube(:width => 660, :height => 372, :autoplay => true) }
      params[:video][:link].insert( params[:video][:link].rindex('autoplay=1') + 10, '&showinfo=0&controls=1&vq=hd720&rel=0') if params[:video][:landing] == '1'
    elsif params[:video][:link].match(/vimeo/)
      params[:video][:link] = "<iframe src='//player.vimeo.com/video/#{params[:video][:link].split("/")[-1]}?autoplay=1' width='660' height='372' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
      video_link_backup = "http://vimeo.com/#{video_link_backup.split("/")[-1]}"
    else
      return render json: { status: 'error', status_text: 'Можно загружать только видео с Ютуба и Вимео.' }
    end

    @video = Video.new( video_params )
    if @video.save
      video_info = VideoInfo.new( video_link_backup )
      video_thumb = video_info.thumbnail_large
      photo = @video.build_photo
      photo.remote_photo_url = video_thumb
      photo.save
      render json: { status: 'video-created', status_text: 'Видео успешно добавлено.', video:
        { thumb: @video.photo.photo_url(:site, :thumb),
          link: @video.link }
      }
    else
      render json: { status: 'error', status_text: 'При добавлении видео произошла ошибка.' }
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_update_params)
      if params[:video][:landing] == '1' && @video[:link].match(/youtu/)
        @video[:link].insert( @video[:link].rindex('autoplay=1') + 10, '&showinfo=0&controls=0')
        @video.save
      end
      redirect_to albums_video_path, notice: 'Видео успешно обновлено.'
    else
      render :edit, error: 'При обновлении видео произошла ошибка.'
    end
  end

  def destroy
    video = Video.find(params[:id])
    if video.destroy
      render json: { status: 'video-deleted', status_text: 'Видео успешно удалено.' }
    else
      render json: { status: 'error', status_text: 'При удалении фото произошла ошибка.' }
    end
  end

  private

    def video_params
      params.require( :video ).permit( :name, :link, :video_main, :landing )
    end

    def video_update_params
      params.require( :video ).permit( :name, :video_main, :landing, :created_at )
    end


end
