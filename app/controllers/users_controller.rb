class UsersController < ApplicationController  
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)   # Not the final implementation!
    if @user.save
      redirect_to @user, :notice => "Signed up!"
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end

end