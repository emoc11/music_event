require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  before(:each) do
    @user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
    @user.save!
  end

  it "returns http success" do
    get :new
    expect(response).to have_http_status(:success)
  end

  it "log nicely a user" do
    get :create, :session => {:login => "emoc11", :password => "rubyonrails"}
    expect(response).to redirect_to("/parties")
  end

  it "disconnect a user logged in" do
    session[:user_id] = @user.id
    delete :destroy
    expect(response).to redirect_to(root_url)
  end

  after(:each) do
    User.delete_all
    session[:user_id] = nil
  end

end