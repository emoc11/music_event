class PartiesController < ApplicationController

  before_action do
   @user_id = 1
  end

  def index
    # On récupère toutes les soirées
  	@parties = Party.all

    # On récupère les id des soirées auxquelles le user est inscrit
  	userParties = PartyUser.where(user_id: @user_id)

    @myParties = Array.new
    number=0

    # On récupère les soirées auxquelles est inscrit le user
  	userParties.each do |p|
      # A partir de la table Party
  		@myParties[number] = Party.find(p.party_id)
  		number += 1
  	end
  end

  def show
    # On récupère les informations sur la soirée
  	@party = Party.find(params[:id])

  	@users = Array.new

    # On récupère les id des utilisateurs qui participent à la soirée
  	partyUsers = PartyUser.where(party_id: params[:id])

    i=0

  	partyUsers.each do |p|
      # On récupère les utilisateurs pour les afficher
		  @users[i] = User.find(p.user_id)
		  i += 1
  	end

    # On regarde si l'utilisateur est inscrit ou non
    @inscription = PartyUser.where(user_id: @user_id, party_id: params[:id])

  	# render status: 404 unless @party != nil

  end

  def suscribe

    # on enregistre l'inscription du user à la soirée
    @inscription = PartyUser.new(params.require(:partyuser).permit(:user_id, :party_id))

    if @inscription.save
      redirect_to :controller => 'parties', :action => 'show', :id => params[:partyuser][:party_id]
    else
      render status: 404
    end

    # redirection sur la page de la soirée
  end

  def unsuscribe

    # on supprime l'inscription du user à la soirée
    PartyUser.where(user_id: params[:unsuscribe][:user_id]).where(party_id: params[:unsuscribe][:party_id]).destroy_all

    # redirection sur la page de la soirée
    redirect_to :controller => 'parties', :action => 'show', :id => params[:unsuscribe][:party_id]
  end

  def new
  end
  def create
    params[:party][:user_id] = 2
    @party = Party.new(params.require(:party).permit(:user_id,:name, :date, :begin_hour, :artist, :price, :adress, :description))
      if @party.save
        redirect_to :controller => 'parties', :action => 'show', :id => @party.id
      else

      end
  end
end