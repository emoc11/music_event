class PartiesController < ApplicationController
  def index
  	@parties = Party.all

  	@myParties = Array.new
  	userParties = PartyUser.where(user_id: 4)
    
    number=0

  	userParties.each do |p|
  		@myParties[number] = Party.find(p.party_id)
  		number += 1
  	end
  end

  def show
  	@party = Party.find(params[:id])

  	@users = Array.new

  	partyUsers = PartyUser.where(party_id: params[:id])

    i=0

  	partyUsers.each do |p|
  		@users[i] = User.find(p.user_id)
  		i += 1
  	end

  	render status: 404 unless @party != nil
  end 

  def suscribe
  	# PartyUser.create(user_id: 1, party_id: params[:id])
  end

  def unsuscribe 

  end

  def new
  end
end
