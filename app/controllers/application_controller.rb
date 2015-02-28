class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_signed_in
    unless admin_signed_in?
      flash[:notice] = 'Вы должны Войти для просмотра данной страницы.'
      redirect_to new_admin_session_url
    end
  end

  def after_sign_in_path_for(resource)
    URI.escape '/свидания-без-слов'
  end

end
