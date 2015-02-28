class RecallsController < ApplicationController
  before_action :ensure_signed_in, except: [:index, :create]
  before_action :set_page, only: [:index]

  def index
    @recalls = Recall.paginate( page: params[:page] ).order('published_at DESC').published
    @recall = Recall.new
    @photo_last = Photo.where( photoable_type: 'Photo' ).last

    @video_last = Video.all_but_main_and_landing.last
    # @video_last = Photo.where( photoable_type: 'Video' ).last
  end


  def create
    @recall = Recall.new(recall_params)

    respond_to do |format|
      if @recall.save
        format.html { redirect_to :back, notice: 'Твой отзыв получен. После проверки модератором он будет опубликован.' }
        format.json { render :show, status: :created, location: :back }
      else
        format.html { render :back }
        format.json { render json: @recall.errors, status: :unprocessable_entity }
      end
    end
  end

  def moderation
    @recalls = Recall.order( 'published_at DESC' ).all
  end

  def show
    respond_to do |format|
      format.json {
        render json: Recall.select(:id, :text).find( params[:id] )
      }
    end
  end

  def update
    recall = Recall.find( params[:id] )
    respond_to do |format|
      if recall.update( recall_update_params )
        format.json { render json: { status: 'recall-updated', status_text: 'Обновление отзыва произошло успешно.', date: recall.published_at.strftime("%d.%m.%y") } }
      else
        format.json { render json: { status: 'error', status_text: 'При обновлении отзыва произошла ошибка.' } }
      end
    end
  end

  def destroy
    recall = Recall.destroy( params[:id] )
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_page
      @page = Page.where( name: '/фото-и-видео-отчёты-и-отзывы-с-прошедших-свиданий-без-слов' ).take
    end

    def recall_params
      params.require(:recall).permit(:name, :email, :text)
    end

    def recall_update_params
      params.require(:recall).permit(:published_at, :published)
    end
end
