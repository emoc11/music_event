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
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def user_params
   
    salt = "CeciEstDuTexteQuiPermetDeSecuriserLePassword"
    real_password = params[:password]
    sha1_password = Digest::SHA1.hexdigest("#{salt}#{real_password}")
    params[:password_digest] = BCrypt::Password.create(sha1_password).to_s
     params.require(:user).permit(:login, :email, :password, :password_digest)
  end

end