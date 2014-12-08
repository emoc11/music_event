require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "GET index" do
    it "/users/ exist with a title" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Tous les utilisateurs")
    end

    it "doesn't displays a list of users if there are no users" do
      User.delete_all
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to_not include("Eileen")
      expect(response.body).to_not include("Benson")
    end

    it "/users/ displays a list of users" do
      User.create(login: "Eileen", email: "Eileen@rs.com", password: "test")
      User.create(login: "Benson", email: "benson@rs.com", password: "test")
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Eileen")
      expect(response.body).to include("Benson")
    end

    it "/users/id show information about the user" do
      user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyruby")
      get :id
      expect(response).to have_http_status(:success)
      expect(response.body).to include("emoc11")

    end
  end

end
