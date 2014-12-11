class PartiesController < ApplicationController

  before_action do
    isconnect?
  end

  def index

    # 1) Soirées créées par l'utilisateur
    @created_parties = Party.where(user_id: @user_id)

    # 2) Soirées auxquelles participent l'utilisateur...
    @subscribed_parties = Array.new

    # 3) ... et leur nombre de participants
    @subscribers_by_party = Array.new

    # Dans la table "PartyUser", on récupère les id des soirées auxquelles le user est inscrit
    user_parties = PartyUser.where(user_id:  @user_id)

    # Dans la table "Party", On récupère les informations sur celles-ci
    user_parties.each do |p|
      @subscribed_parties.push(Party.find(p.party_id))
      # ainsi que le nombre de participants à chacune
      @subscribers_by_party.push(PartyUser.where(party_id: @subscribed_parties.last.id).count) 
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

      @subscribers = Array.new

      party_users.each do |p|
      # On récupère les utilisateurs pour les afficher
      @subscribers << User.find(p.user_id)

      # On regarde si l'utilisateur est inscrit ou non
      @inscription = PartyUser.where(user_id: @user_id, party_id: params[:id])

      if @creator.id == @user_id
        @user_is_creator = true
      else
        @user_is_creator = false
      end
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
    @subscribers_by_party = Array.new
    # et leur organisateur
    @party_creator = Array.new

    # Pour chaque soirée, on récupère le nombre de participants
    @parties.each do |party|
      # Les id des users participants
      @subscribers_by_party << PartyUser.where(party_id: party.id).count

      # On récupère l'organisateur
      @party_creator << User.find(party.user_id)
    end
  end

  def subscribe

    # on enregistre l'inscription du user à la soirée
    @inscription = PartyUser.new(params.require(:partyuser).permit(:user_id, :party_id))

    if @inscription.save
      redirect_to :controller => 'parties', :action => 'show', :id => params[:partyuser][:party_id]
    else
      render status: 404
    end

    # redirection sur la page de la soirée
  end

  def unsubscribe

    # on supprime l'inscription du user à la soirée
    PartyUser.where(user_id: params[:unsubscribe][:user_id]).where(party_id: params[:unsubscribe][:party_id]).destroy_all

    # redirection sur la page de la soirée
    redirect_to :controller => 'parties', :action => 'show', :id => params[:unsubscribe][:party_id]
  end

  # Création d'une nouvelle party
  def create
    params[:party][:user_id] = @user_id
    @party = Party.new(params.require(:party).permit(:user_id,:name, :date, :begin_hour, :artist, :price, :adress, :description))
      if @party.save
        @partyUser = PartyUser.new(party_id: @party.id, user_id: @user_id)
        if @partyUser.save
          redirect_to :controller => 'parties', :action => 'show', :id => @party.id
        else
          flash.now.alert = "Something went wrong, please contact admin."
        end
      else
        flash.now.alert = "Please fill anything before creating the event !"
        render 'new'
      end
  end

  def destroy
    if Party.exists?(:id => params[:id])
      Party.find(params[:id]).destroy
      # On supprime la soirée
      # On supprime les inscriptions qui lui étaient liées
      PartyUser.destroy_all(:party_id => params[:id])
      redirect_to parties_path
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def edit
    if Party.exists?(:id => params[:id])
      @parties = Party.find(params[:id])
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def update
    if Party.exists?(:id => params[:id])
      @parties = Party.find(params[:id])
      if @parties.update(party_params)

         redirect_to :controller => 'parties', :action => 'show', :id => @parties.id
      else
         render :action => 'edit'
      end
    else
      render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def party_params
    params.require(:party).permit(:user_id, :name, :date, :begin_hour, :artist, :price, :adress, :description)
  end
end