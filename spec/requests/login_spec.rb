require 'spec_helper'
describe "The login process", :type => :feature do

  before :each do
    User.create(:login => "emoc11", :email => 'emoc11@free.fr', :password => 'rubyonrails', :password_confirmation => 'rubyonrails')
  end

  it "signs me in -- good login" do
    visit '/'
      fill_in 'Login', :with => 'emoc11'
      fill_in 'Password', :with => 'rubyonrails'
      click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end

  it "signs me in -- wrong login/password" do
    visit '/'
      fill_in 'Login', :with => 'emoc22'
      fill_in 'Password', :with => 'rubyonrail'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
  end

  it "signs me in -- wrong login" do
    visit '/'
      fill_in 'Login', :with => 'emoc22'
      fill_in 'Password', :with => 'rubyonrails'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
  end

  it "signs me in -- wrong password" do
    visit '/'
      fill_in 'Login', :with => 'emoc11'
      fill_in 'Password', :with => 'rubyonrail'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
  end

  it "signs me in -- no info" do
    visit '/'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
  end

  after :each do
    User.delete_all
  end
end