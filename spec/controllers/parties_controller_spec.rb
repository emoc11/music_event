require 'rails_helper'

RSpec.describe PartiesController, :type => :controller do

  render_views

  context "Not logged in, can't access :" do
    it "/parties/" do
      get :index
      expect(response).to have_http_status(302)
    end

    it "/parties/id" do
      user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
      user.save!

      party = Party.create(user_id: user.id, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
      party.save!
      get :show, :id => party.id
      expect(response).to have_http_status(302)
    end

    it "/parties/new" do
      get :new
      expect(response).to have_http_status(302)
    end

    it "/parties/all" do
      get :all
      expect(response).to have_http_status(302)
    end
  end

  context "Logged in as emoc11->has a party named 'Partie de emoc11' :" do
    before(:each) do
      @user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
      @user.save!
      @party = Party.create(user_id: @user.id, name: "Partie de emoc11", date: "2014-04-11", begin_hour: 18, artist: "emoc11", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil", description: "La meilleure soirée !")
      @party.save!
      session[:user_id] = @user.id

      @user2 = User.create(login: "emoc22", email: "emoc22@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
      @user2.save!
      @party2 = Party.create(user_id: @user2.id, name: "Emoc22 event", date: "2014-04-11", begin_hour: 18, artist: "emoc22", price: 10, adress: "autre", description: "Mieux que l'autre, ou pas !")
      @party2.save!
    end

    it "/parties/ show my created event" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("My created events")
      expect(response.body).to include("Partie de emoc11")
    end

    it "/parties/ show my subscribed event" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("My subscribed events")
      expect(response.body).not_to include("Emoc22 event")

      # inscription à la soirée de Emoc22
      partyUser = PartyUser.create(user_id: @user.id, party_id: @party2.id)
      partyUser.save!

      get :index
      expect(response.body).to include("My subscribed events")
      expect(response.body).to include("Emoc22 event")
    end

    it "/parties/id show informations about the party" do
      get :show, :id => @party.id
      expect(response.body).to include("Partie de emoc11")
      expect(response.body).to include("La meilleure soirée !")
      expect(response.body).to include("Hosted by")
      expect(response.body).to include("you")

      get :show, :id => @party2.id
      expect(response.body).to include("Emoc22 event")
      expect(response.body).to include("Mieux que l&#39;autre, ou pas !")
      expect(response.body).to include("Hosted by")
      expect(response.body).to include("emoc22")
    end

    it "/parties/id show subscriber's list" do
      partyUser = PartyUser.create(user_id: @user.id, party_id: @party2.id)
      partyUser.save!
      get :show, :id => @party2.id
      expect(response.body).to include("Subscribers :")
      expect(response.body).to include("emoc11")
      expect(response.body).to include("emoc22")
    end

    it "/parties/all show party's list" do
      get :all
      expect(response.body).to include("Partie de emoc11")
      expect(response.body).to include("Emoc22 event")
    end

    after(:each) do
      session[:user_id] = nil
    end
  end
end
