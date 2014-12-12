require 'spec_helper'
describe "The new party's form", :type => :feature do

  before(:each) do
    @user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
    @user.save!
    visit '/'
    fill_in 'Login', :with => 'emoc11'
    fill_in 'Password', :with => 'rubyonrails'
    click_button 'Log in'
  end

  it "New party -- good infos" do
    visit '/parties/new'
    fill_in "Name", :with => 'name bla bla'
    fill_in "Date", :with => '25/12/2014'
    fill_in "Begin hour", :with => '12'
    fill_in "Artist", :with => 'moi'
    fill_in "Price", :with => '14'
    fill_in "Adress", :with => '3 rue'
    click_button "Save my party"
    expect(page).to have_http_status(:success)
    expect(page).to have_content "Host :"
    expect(page).to have_content "name bla bla"
  end

  it "New party -- no info" do
    visit '/parties/new'
    click_button "Save my party"
    expect(page).to have_content "Please fill anything before creating the event !"
  end

  it "Update party -- try to change something" do
    party = Party.create(user_id: @user.id, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!
    visit('/parties/1/edit')
    fill_in "Name", :with => 'name only'
    fill_in "Date", :with => '25/12/2014'
    fill_in "Begin hour", :with => '12'
    fill_in "Artist", :with => 'artist'
    fill_in "Price", :with => '12'
    fill_in "Adress", :with => '3 rue destienne'
    click_button "Update"
    expect(page).to have_http_status(:success)
    expect(page).not_to have_content "name bla bla"
    expect(page).to have_content "name only"
  end

  after :each do
    Party.delete_all
  end
end