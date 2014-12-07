class UsersController < ApplicationController  
  def new
    @user = User.new 
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :password, :salt, :password_verif)
  end
end
