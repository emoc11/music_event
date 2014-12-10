class UsersController < ApplicationController

  # Liste de tous les utilisateurs
  def index
    isconnect?
    @users = User.all
  end

  # Affichage des infos d'un utilisateur
  def show
    if User.exists?(:id => params[:id])
      isconnect?
      @user = User.find(params[:id])
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  # Affichage du formulaire d'ajout
  def new
    if current_user.blank?
    else
      redirect_to "/parties"
    end
    @user = User.new
  end

  # Inscription d'un utilisateur
  def create
    @user = User.new(user_params)   # Not the final implementation!
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, :notice => "Signed up!"
    else
      render 'new'
    end
  end

  def edit
    if User.exists?(:id => params[:id])
      isconnect?
      @user = User.find(params[:id])
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render'edit'
    end
  end

  # définition des paramètre pour l'inscription
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end

end