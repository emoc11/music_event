class UsersController < ApplicationController
  def new
  end

  def index
    @users = User.all
  end

  def show
    puts params
  end
end