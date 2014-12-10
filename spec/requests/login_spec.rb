require 'spec_helper'
describe "The login process", :type => :feature do

  before :each do
    User.create(:login => "emoc11", :email => 'emoc11@free.fr', :password => 'rubyonrails', :password_confirmation => 'rubyonrails')
  end

  it "signs me in" do
    visit '/'
      fill_in 'Login', :with => 'emoc11'
      fill_in 'Password', :with => 'rubyonrails'
      click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end
end