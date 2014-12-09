require 'spec_helper'
describe "The signup process", :type => :feature do

  # before :each do
  #   User.make(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrail', :password_confirmation => 'rubyonrails')
  # end

  it "Signs me up" do
    visit '/signup'
      fill_in "Login", :with => 'emoc11'
      fill_in "Email", :with => 'emoc11@free.fr'
      fill_in "Password", :with => 'rubyonrails'
      fill_in "Confirmation", :with => 'rubyonrails'
      click_button "Create my account"
    expect(page).to have_content "emoc11"
  end
end