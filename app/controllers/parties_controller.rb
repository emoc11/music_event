class PartiesController < ApplicationController
  def index
  	@parties = Party.all
  end

  def show
  	@party = Party.find(params[:id])
  	render status: 404 unless @party != nil
  end 
  
  def new
  end
end
