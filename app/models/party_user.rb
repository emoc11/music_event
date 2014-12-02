class PartyUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :party

  validates :user_id, presence: true
  validates :party_id, presence: true
end
