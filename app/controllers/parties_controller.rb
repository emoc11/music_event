class PartiesController < ApplicationController

  before_action do
    isconnect?
  end

  def index

    # 1) Soirées créées par l'utilisateur
    @created_parties = Party.where(user_id: @user_id)

    # 2) Soirées auxquelles participent l'utilisateur
    @suscribed_parties = Array.new
    i=0

    # On récupère les id des soirées auxquelles le user est inscrit
    user_parties = PartyUser.where(user_id: @user_id)

    # On récupère les soirées auxquelles est inscrit le user, autres que celles créées par lui
    user_parties.each do |p|
      @suscribed_parties[i] = Party.find(p.party_id)
      i+= 1
    end

  end

  def show
    # test si existe en BDD avant utilisation
    if Party.exists?(:id => params[:id])
      # On récupère les informations sur la soirée
      @party = Party.find(params[:id])
      # Les informations sur le créateur de la soirée
      @creator = User.find(@party.user_id)
      # On récupère les id des utilisateurs qui participent à la soirée
      party_users = PartyUser.where(party_id: params[:id])

      @suscribers = Array.new

      party_users.each do |p|
      # On récupère les utilisateurs pour les afficher
      @suscribers << User.find(p.user_id)

      # On regarde si l'utilisateur est inscrit ou non
      @inscription = PartyUser.where(user_id: @user_id, party_id: params[:id])
    end
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end

  end

  # Montrer toutes les soirées
  def all
    # On récupère toutes les soirées
    @parties = Party.all

    # leurs participants
    @suscribers_by_party = Array.new
    # et leur organisateur
    @party_creator = Array.new

    # Pour chaque soirée, on récupère les participants
    @parties.each_with_index do |party, index|
      # Les id des users participants
      @inscriptions = PartyUser.where(party_id: party.id)
      @suscribers_by_party[index] = Array.new

      # Pour chaque inscription
      @inscriptions.each do |i|
        # on récupère à partir du user_id le user correspondant
        # on le stocke dans la liste des inscrits à la soirées
        @suscribers_by_party[index] << User.find(i.user_id)
      end

      # On récupère l'organisateur
      @party_creator << User.find(party.user_id)
    end 
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

  # Création d'une nouvelle party
  def create
    params[:party][:user_id] = @user_id
    @party = Party.new(params.require(:party).permit(:user_id,:name, :date, :begin_hour, :artist, :price, :adress, :description))
      if @party.save
        redirect_to :controller => 'parties', :action => 'show', :id => @party.id
      else

      end
  end

  def destroy
    # On supprime la soirée
    Party.find(params[:id]).destroy
    # On supprime les inscriptions qui lui étaient liées
    PartyUser.destroy_all(:party_id => params[:id])
    redirect_to parties_path
  end
end