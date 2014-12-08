class PartiesController < ApplicationController

  def index
    # On récupère toutes les soirées
  	@parties = Party.all

    # On récupère les id des soirées auxquelles le user est inscrit
  	userParties = PartyUser.where(user_id: 1)
    
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
      # On récupère les utilisateurs, autre que celui connecté, pour les afficher
      if(p.user_id != 1)
  		  @users[i] = User.find(p.user_id)
  		  i += 1
      end
  	end

    # On regarde si l'utilisateur est inscrit ou non
    @inscription = PartyUser.where(user_id: 1, party_id: params[:id])

  	# render status: 404 unless @party != nil

  end 

  def suscribe

    # on enregistre l'inscription du user à la soirée 
    @partyuser = PartyUser.new(params.require(:partyuser).permit(:user_id, :party_id))

    # if @partyuser.save
    #   flash[:success] = "Vous êtes bien inscrit à l'événement"
    # else
    #   flash[:error] = "Une erreur a empêché l'inscription à l'événement"
    # end

    # redirection sur la page de la soirée
    redirect_to :controller => 'parties', :action => 'show', :id => params[:partyuser][:party_id]
  end

  def unsuscribe 

    # on supprime l'inscription du user à la soirée 
    PartyUser.where(user_id: params[:unsuscribe][:user_id]).where(party_id: params[:unsuscribe][:party_id]).destroy_all

    # redirection sur la page de la soirée
    redirect_to :controller => 'parties', :action => 'show', :id => params[:unsuscribe][:party_id]
  end

  def new
  end
end
