class PagesController < ApplicationController
  before_action :ensure_signed_in, only: [:edit, :update]
  before_action :set_page, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to URI.escape(@page.name), notice: 'Страница успешно отредактирована.' }
        format.json { render :show, status: :ok, location: URI.escape(@page.name) }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def rules
    @page = Page.where( name: '/правила-свиданий-без-слов' ).take
  end
  
  def entities
	@page = Page.where( name: '/статьи' ).take
  end

	  def where_to_meet
		@page = Page.where( name: '/статьи/где-познакомиться' ).take
	  end
	  
	  def where_to_find_a_girl
		@page = Page.where( name: '/статьи/где-найти-девушку' ).take
	  end
	  
	  def where_to_find_a_man
		@page = Page.where( name: '/статьи/где-найти-парня' ).take
	  end
	  
	  def looking_for_party
		@page = Page.where( name: '/статьи/вечеринки-знакомства' ).take
	  end
	  
	  def speed_dating
		@page = Page.where( name: '/статьи/быстрые-свидания' ).take
	  end
  

  def structure
    @page = Page.where( name: '/что-тебя-ожидает' ).take
  end

  def info_page
    @page = Page.where( name: '/informacionnaja-stranica' ).take
  end

  private
    def page_params
      params.require( :page ).permit( :title,
                                      :content,
                                      :ps,
                                      :sidebar_title,
                                      :meta_description )
    end

    def set_page
      @page = Page.find( params[:id] )
    end

end
