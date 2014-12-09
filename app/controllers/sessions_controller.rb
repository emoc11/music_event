class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(login: params[:session][:login])
    attempted_password = params[:session][:password]
    salt = "CeciEstDuTexteQuiPermetDeSecuriserLePassword"
    sha1_password = Digest::SHA1.hexdigest("#{salt}#{attempted_password}")
	BCrypt::Password.new(user.password_digest) == sha1_password
    if user && user.authenticate(params[:session][:password])
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