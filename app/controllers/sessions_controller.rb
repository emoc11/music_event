class SessionsController < ApplicationController

  # Redirection du membre 
  def new
    # Si le membre est connecté, on le redérige vers la page d'accueil
    if current_user.present?
      redirect_to "/parties"
    end
  end

  # Création d'un nouveau membre en BDD 
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