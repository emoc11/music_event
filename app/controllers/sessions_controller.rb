class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(login: params[:session][:login], password_digest: params[:session][:password])

    if user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out
    redirect_to root_url
  end
end