class PartiesController < ApplicationController
  before_action :ensure_signed_in, only: [:edit, :update, :destroy]
  before_action :set_party, only: [:edit, :update, :destroy]

  def index
    @parties = Party.all.order( 'date ASC' )
    @page = Page.where( name: '/parties' ).first
  end

  def new
    @party = Party.new
  end

  def edit
  end

  def create
    @party = Party.new(party_params)

    respond_to do |format|
      if @party.save
        format.html { redirect_to all_parties_path, notice: 'Вы успешно создали новую вечеринку.' }
        format.json { render :show, status: :created, location: all_parties_path }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to all_parties_path, notice: 'Информация о вечеринке была успешно обновлена.' }
        format.json { render :show, status: :ok, location: all_parties_path }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to all_parties_path, notice: 'Вы успешно удалили вечеринку.' }
      format.json { head :no_content }
    end
  end

  private
    def set_party
      @party = Party.find(params[:id])
    end

    def party_params
      params.require(:party).permit( :name, :description, :address, :ps, :date )
    end
end
