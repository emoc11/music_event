class PartyUser < ActiveRecord::Base
  # Liaison entre les tables
  belongs_to :users
  belongs_to :parties

  # Validation des différents champs
  validates :user_id, presence: true
  validates :party_id, presence: true
end
