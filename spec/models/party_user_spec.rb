require "rails_helper"

RSpec.describe PartyUser, :type => :model do

  it "user can follow a party" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    user.save!

    party = Party.create(user: user, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!

    user2 = User.create(login: "test", email: "test@free.fr", password: "ruuubbyyy")
    user2.save!

    linkParty = PartyUser.create(user: user2, party: party)
    linkParty.save!

    party_found = PartyUser.last
    expect(party_found.user_id).to eq(user2.id)
    expect(party_found.party_id).to eq(party.id)
    expect(Party.find(party_found.party_id).name).to eq("Une partie trop cool")
  end

  it "user can follow a party and return to no follow" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    user.save!

    party = Party.create(user: user, name: "Une partie trop cool", date: "2014-04-11", begin_hour: 18, artist: "Moi", price: 10, adress: "3 rue d'Estienne d'Orves 94110 Arcueil")
    party.save!

    user2 = User.create(login: "test", email: "test@free.fr", password: "ruuubbyyy")
    user2.save!

    linkParty = PartyUser.create(user: user2, party: party)
    linkParty.save!

    party_found = PartyUser.last
    expect(party_found.user_id).to eq(user2.id)
    expect(party_found.party_id).to eq(party.id)
    expect(Party.find(party_found.party_id).name).to eq("Une partie trop cool")

    expect(party_found.valid?).to eq(true)

    PartyUser.where(:user_id => user2.id).destroy_all

    party_found = PartyUser.last
    expect(party_found).to eq(nil)
  end
end
