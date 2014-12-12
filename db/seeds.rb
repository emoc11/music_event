# -------------------------- Création des users

users_list = [
  [ "Côme", "email@free.fr", "rubyonrails" ],
  [ "Améziane", "ameziane@hetic.net", "rubyonrails" ],
  [ "Pierre", "pierrezajac@hotmail.fr", "rubyonrails" ],
  [ "Jeremy", "jerem.gacou@hotmail.fr", "rubyonrails" ]
]

users_list.each do |login, email, password|
  user = User.create( login: login, email: email, password: password, password_confirmation: password )
end

# -------------------------- Créations des parties

party_list = [
  [ 1, "Saturday night fever", "25/12/2014", 18, "-M-", 8, "Chez moi" ],
  [ 2, "The best one", "25/12/2014", 18, "Booba, Beyonce...", 10, "Stade de France" ],
  [ 2, "An other one", "29/12/2014", 20, "Mon groupe", 6, "Mairie de Paris" ],
  [ 4, "Jeremy's night", "24/12/2014", 20, "Jerem's crew", 3, "Local st germain à Montreuil" ]
]

party_list.each do |userid, name, date, hour, artist, price, address|
  party = Party.create( user_id: userid, name: name, date: date, begin_hour: hour, artist: artist, price: price, adress: address )
end

# -------------------------- Inscription des users aux parties

partyUser_list = [
  [ 1, 3],
  [ 2, 4],
  [ 1, 4],
  [ 3, 2],
  [ 3, 4],
  [ 3, 3],
  [ 1, 1],
  [ 2, 2],
  [ 2, 3],
  [ 4, 4]
]

partyUser_list.each do |userid, partyid|
  party = PartyUser.create( user_id: userid, party_id: partyid )
end