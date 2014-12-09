class Party < ActiveRecord::Base
  has_many :party_users
  has_many :users, :through => :party_users

  validates :user_id, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :begin_hour, presence: true
  validates :artist, presence: true
  validates :price, presence: true
  validates :adress, presence: true
  # validates :description

end
