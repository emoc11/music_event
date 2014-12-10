require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "GET index" do

    context 'must be logged in to access :' do
      it "/users/" do
        get :index
        expect(response).to have_http_status(302)
      end

      it "/users/id" do
          user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyruby", password_confirmation: "rubyruby")
          get :show, :id => user.id
          expect(response).to have_http_status(302)
      end
    end

    it "/users/ exist with a title" do
      user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
      user.save!
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("All users")
    end

    it "/users/ displays a list of users" do
      user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
      user.save!
      user1 = User.create(login: "test", email: "test@free.fr", password: "rubyruby", password_confirmation: "rubyruby")
      user1.save!
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("emoc11")
      expect(response.body).to include("test")
    end

    it "/users/id show information about the user" do
      user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyruby", password_confirmation: "rubyruby")
      user.save!
      get :show, :id => user.id
      expect(response).to have_http_status(:success)
      expect(response.body).to include("emoc11")
      expect(response.body).to include("emoc11@free.fr")
    end
  end
end