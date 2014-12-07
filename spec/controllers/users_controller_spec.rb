require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "GET index" do
    it "/users/ exist with a title" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Tous les utilisateurs")
    end

    it "displays a list of users" do
      User.create(name: "Eileen", email: "Eileen@rs.com")
      User.create(name: "Benson", email: "benson@rs.com")
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Eileen")
      expect(response.body).to include("Benson")
    end

    it "doesn't displays a list of users if there are no users" do
      User.delete_all
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to_not include("Eileen")
      expect(response.body).to_not include("Benson")
    end
  end

end
