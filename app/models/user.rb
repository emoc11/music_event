class User < ActiveRecord::Base
  has_many :parties

  validates :login , presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  validates :password, presence: true, confirmation: true # http://api.rubyonrails.org/ -- rechercher "validates"
end
