require 'spec_helper'
describe "The signup process", :type => :feature do

  # before :each do
  #   User.make(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrail', :password_confirmation => 'rubyonrails')
  # end

  it "Signs me up -- good sign up" do
    visit '/signup'
    fill_in "Login", :with => 'emoc11'
    fill_in "Email", :with => 'emoc11@free.fr'
    fill_in "Password", :with => 'rubyonrails'
    fill_in "Confirmation", :with => 'rubyonrails'
    click_button "Create my account"
    expect(page).to have_content "Signed up!"
  end

  it "Signs me up -- wrong email format" do
    visit '/signup'
    fill_in "Login", :with => 'emoc11'
    fill_in "Email", :with => 'emoc11@.fr'
    fill_in "Password", :with => 'rubyonrails'
    fill_in "Confirmation", :with => 'rubyonrails'
    click_button "Create my account"
    expect(page).to have_content "Email is invalid"
  end

  it "Signs me up -- wrong password confirmation" do
    visit '/signup'
    fill_in "Login", :with => 'emoc11'
    fill_in "Email", :with => 'emoc11@free.fr'
    fill_in "Password", :with => 'rubyonrails'
    fill_in "Confirmation", :with => 'rubyruby'
    click_button "Create my account"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "Signs me up -- user already exist -- login" do
    user = User.create(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrails', :password_confirmation => 'rubyonrails')
    user.save!
    visit '/signup'
    fill_in "Login", :with => 'emoc11'
    fill_in "Email", :with => 'emoc22@free.fr'
    fill_in "Password", :with => 'rubyonrails'
    fill_in "Confirmation", :with => 'rubyonrails'
    click_button "Create my account"
    expect(page).to have_content "Login has already been taken"
  end

  it "Signs me up -- user already exist -- login" do
    user = User.create(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrails', :password_confirmation => 'rubyonrails')
    user.save!
    visit '/signup'
    fill_in "Login", :with => 'emoc22'
    fill_in "Email", :with => 'emoc11@free.fr'
    fill_in "Password", :with => 'rubyonrails'
    fill_in "Confirmation", :with => 'rubyonrails'
    click_button "Create my account"
    expect(page).to have_content "Email has already been taken"
  end

  it "Signs me up -- no info" do
    visit '/signup'
    click_button "Create my account"
    expect(page).to have_content "The form contains 7 errors."
  end

  after :each do
    User.delete_all
  end
end