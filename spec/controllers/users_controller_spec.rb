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

    context 'when password is invalid' do
      it 'renders the page with error' do
        user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rub", password_confirmation: "rub")

        post :new, session: { email: user.email, password: 'invalid' }

        expect(response).to render_template(:new)
        expect(flash[:notice]).to match(/^Email and password do not match/)
      end
    end

    context 'when password is valid' do
      it 'sets the user in the session and redirects them to their dashboard' do
        user = create(:user)

        post :new, session: { email: user.email, password: user.password }

        expect(response).to redirect_to '/parties'
        expect(controller.current_user).to eq user
      end
    end
  end
end
