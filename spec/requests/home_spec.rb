require 'spec_helper'
describe "The signup process", :type => :feature do

  # before :each do
  #   User.make(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrail', :password_confirmation => 'rubyonrails')
  # end

  it "Signs me up" do
    visit '/signup'
      fill_in "login", :with => 'emoc11'
      fill_in "email", :with => 'emoc11@free.fr'
      fill_in "password", :with => 'rubyonrails'
      fill_in "password_verif", :with => 'rubyonrails'
      click_button "Create my account"
    expect(page).to have_content 'Success'
  end
end