require "rails_helper"

RSpec.describe Party, :type => :model do

  it "can save a party" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    user.save!

    party = Party.create(user: user, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!

    found = Party.last
    expect(found.user_id).to eq(user.id)
    expect(found.name).to eq("Une partie trop cool")
    expect(found.description).to eq(nil)

    party = Party.create(user: user, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil", description: "c'est une description")
    party.save!

    found = Party.last
    expect(found.user_id).to eq(user.id)
    expect(found.name).to eq("Une partie trop cool")
    expect(found.description).to eq("c'est une description")
  end

  it "requires login, email and password" do
    user = Party.new
    expect(user.valid?).to eq(false)

    user.login = "emoc11"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free.fr"
    expect(user.valid?).to eq(false)

    user.password = "rubyonrails"
    expect(user.valid?).to eq(true)
  end

  it "requires a valid email format" do
    user = Party.new(login: "emoc11", password: "rubyonrails")
    expect(user.valid?).to eq(false)

    user.email = "emoc11"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free."
    expect(user.valid?).to eq(false)

    user.email = "emoc11@.fr"
    expect(user.valid?).to eq(false)

    user.email = "@free.fr"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free.fr"
    expect(user.valid?).to eq(true)
  end

  it "is impossible to add the same email/login twice" do
    user = Party.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    expect(user.valid?).to eq(true)

    other_user = Party.create(login: "emoc", email: "emoc11@free.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = Party.create(login: "emoc11", email: "emoc11@hotmail.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = Party.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = Party.create(login: "emoc", email: "emoc11@hotmail.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(true)
  end
end
