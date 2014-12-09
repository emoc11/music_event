class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_login(params[:session][:login]).authenticate(params[:session][:password])
    if user
      session[:user_id] = user.id
      cookies[:user_id] = user.id
      redirect_to user, :notice => "Welcome back, #{user.login} !"
    else
      flash.now.alert = "Invalid email or password ; test = #{params[:session][:password]}"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    cookies[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end