class SessionsController < ApplicationController

  def new
    if current_user.blank?
    else
      redirect_to "/parties"
    end
  end

  # Connexion d'un utilisateur
  def create
    if User.exists?(:login => params[:session][:login])
      user = User.find_by_login(params[:session][:login]).authenticate(params[:session][:password])
      if user
        session[:user_id] = user.id
        redirect_to "/parties", :notice => "Welcome back, #{user.login} !"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  # Deconnexion d'un utilisateur
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end