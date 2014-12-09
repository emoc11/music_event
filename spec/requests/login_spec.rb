require 'spec_helper'
describe "The login process", :type => :feature do

  before :each do
    User.make(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrails', :password_confirmation => 'rubyonrails')
  end

  it "signs me in" do
    visit '/'
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign in'
    expect(page).to have_content 'Success'
  end
end