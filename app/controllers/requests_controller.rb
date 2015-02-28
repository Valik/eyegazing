class RequestsController < ApplicationController
  before_action :ensure_signed_in, only: [:destroy, :index]
  before_action :set_request, only: :destroy

  def new
    @request = Request.new
    @party = Party.find( params[:id] ) if params[:id]
    @page = Page.where( name: '/подать-заявку' ).take
  end

  def index
    @requests = Request.order('created_at DESC').group('id, date(party_date)').all
  end

  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        @request.create_photo(photo: params[:request][:photo]) if params[:request][:photo]

        RequestMailer.request_email(@request).deliver

        format.html { redirect_to all_parties_path, notice: 'Спасибо! Твоя заявка принята.' }
        format.json { render :show, status: :created, location: all_parties_path }
      else
        format.html { @page = Page.where( name: '/подать-заявку' ).take; render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.json {
        request = Request.select(:id, :answer).find( params[:id] )
        render json: { id: request.id, text: request.answer }
      }
    end
  end

  # def update
  #   respond_to do |format|
  #     if @request.update(request_params)
  #       format.html { redirect_to @request, notice: 'Request was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @request }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @request.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Заявка успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

  #   # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit( :name, :age, :email, :party_date, :vk, :answer )
    end
end
