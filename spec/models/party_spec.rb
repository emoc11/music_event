require "rails_helper"

RSpec.describe Party, :type => :model do

  it "can save a party" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
    user.save!

    party = Party.create(user_id: user.id, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!

    found = Party.last
    expect(found.user_id).to eq(user.id)
    expect(found.name).to eq("Une partie trop cool")
    expect(found.description).to eq(nil)

    party = Party.create(user_id: user.id, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil", description: "c'est une description")
    party.save!

    found = Party.last
    expect(found.user_id).to eq(user.id)
    expect(found.name).to eq("Une partie trop cool")
    expect(found.description).to eq("c'est une description")
  end

  it "can't save a wrong user_id" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
    user.save!

    party = Party.create(user_id: user.id, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!

    expect(party.valid?).to eq(true)
    party.user_id = nil
    expect(party.valid?).to eq(false)
  end

  it "requires user, name, date, hour, artist, price and adresse" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails", password_confirmation: "rubyonrails")
    user.save!

    party = Party.new
    expect(party.valid?).to eq(false)

    party.user_id = user.id
    expect(party.valid?).to eq(false)

    party.name = "une partie trop cool !"
    expect(party.valid?).to eq(false)

    party.date = "2014-04-11"
    expect(party.valid?).to eq(false)

    party.begin_hour = 18
    expect(party.valid?).to eq(false)

    party.artist = "Moi le plus grand"
    expect(party.valid?).to eq(false)

    party.price = 12
    expect(party.valid?).to eq(false)

    party.adress = "3 rue là où tu veux"
    expect(party.valid?).to eq(true)

    party.description = "Une petite description"
    expect(party.valid?).to eq(true)
  end
end
