require 'bcrypt'

class User < ActiveRecord::Base
  # Cryptage du password
  has_secure_password

  # Validation des différents champs
  validates :login, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }, presence: true, confirmation: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: true

  before_save {
    email.downcase!
  }
end