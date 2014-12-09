describe "the signin process", :type => :feature do
  before :each do
    User.make(:login => "emoc11" ,:email => 'emoc11@free.fr', :password => 'rubyonrail', :password_confirmation => 'rubyonrail')
  end

  it "signs me in" do
    visit '/sessions/new'
    within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Success'
  end
end