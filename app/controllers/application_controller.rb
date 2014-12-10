class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Verification si User connecté ou non -> si non, redirection vers accueil avec notice
  def isconnect?
    if current_user.blank?
      redirect_to root_url, :notice => "You can't access this section without being logged !"
    else
      @user_id = current_user.id
    end
  end

  # Redéfinition du current_user pour qu'il aille chercher la bonne session comprenant les infos de connexion
  helper_method :current_user
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] && User.exists?(:id => session[:user_id])
  end
end
