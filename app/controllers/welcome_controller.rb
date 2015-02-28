class WelcomeController < ApplicationController

  respond_to :html

  def index
    @page = Page.where( name: '/свидания-без-слов' ).take
    @main_video = Video.where(video_main: true).take
    @videos = Video.order('created_at DESC').all_but_main_and_landing.limit(5)
  end

  def landing
    @page = Page.where( name: '/' ).take
    @main_video = Video.where(landing: true).take
    @videos = Video.order('created_at DESC').all_but_main_and_landing.limit(5)
  end

  def subscribe
    if params[:b_4bf0869d20f3e9481c368cd3b_fbe2cbfa25].empty?
      gb = Gibbon::API.new
      subscribed = gb.lists.subscribe({:id => 'fbe2cbfa25', :email => {:email => params[:EMAIL]}, :merge_vars => {:FNAME => params[:FNAME], :AGE => params[:AGE]}, :double_optin => false, :send_welcome => true})
      p subscribed
      if subscribed['status'] == 'error'
        case subscribed['name']
        when 'List_AlreadySubscribed'
          redirect_to :back, notice: 'Ты уже подписан на рассылку!'
        else
          redirect_to real_root_path, notice: 'При обработке заявки произошла ошибка. Попробуй снова или напиши мне на почту eyegaz@gmail.com'
        end
      else
        redirect_to real_root_path, notice: 'Ты успешно подписался на рассылку!'
      end
    else
      redirect_to real_root_path
    end
  end

end
