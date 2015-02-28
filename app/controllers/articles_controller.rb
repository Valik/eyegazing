class ArticlesController < ApplicationController
  before_action :ensure_signed_in, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  respond_to :html, only: [:index, :show, :update, :destroy]
  respond_to :json, only: :show

  def index
    @articles = Article.paginate( page: params[:page] ).order('created_at DESC')
  end

  def show
    render json: { article: { text: @article.text } }
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: 'Статья создана успешно.'
    else
      redirect_to edit_path( @article ), error: 'При создании статьи произошла ошибка.'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: 'Статья обновлена успешно.'
    else
      redirect_to edit_path( @article ), error: 'При обновлении статьи произошла ошибка.'
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Статья удалена успешно.'
    else
      redirect_to edit_path( @article ), error: 'При удалении статьи произошла ошибка.'
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit( :subject, :question, :text, :author )
    end

end