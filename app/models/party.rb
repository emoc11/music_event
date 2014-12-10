class Party < ActiveRecord::Base
  # Liaison entre les tables
  has_many :party_users
  has_many :users, :through => :party_users

  # Validation des différents champs, "description" facultative
  validates :user_id, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :begin_hour, presence: true
  validates :artist, presence: true
  validates :price, presence: true
  validates :adress, presence: true
  # validates :description

end
