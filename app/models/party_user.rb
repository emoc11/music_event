class PartyUser < ActiveRecord::Base
  belongs_to :users
  belongs_to :parties

  validates :user_id, presence: true
  validates :party_id, presence: true
end
