require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "GET index" do

    it "/users/ exist with a title" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Tous les utilisateurs")
    end

    context 'when there is no user' do
      it "doesn't displays a list if there is no user" do
        User.delete_all
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to_not include("Eileen")
        expect(response.body).to_not include("Benson")
      end
    end

    context 'when there is some users' do
      it "/users/ displays a list of users" do
        User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
        User.create(login: "test", email: "test@free.fr", password: "rubyruby", password_confirmation: "rubyruby")
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to include("emoc11")
        expect(response.body).to include("test")
      end

      it "/users/id show information about the user" do
        user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyruby", password_confirmation: "rubyruby")
        get :show, :id => user.id
        expect(response).to have_http_status(:success)
        expect(response.body).to include("emoc11")
        expect(response.body).to include("emoc11@free.fr")
      end
    end
  end
end