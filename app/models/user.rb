require 'bcrypt'

class User < ActiveRecord::Base
  # Cryptage du password
  has_secure_password

  # Validation des différents champs
<<<<<<< HEAD
  validates :login, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true, confirmation: true
=======
  validates :login, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true, confirmation: true, :on => :create
>>>>>>> aa2bdbd457274e799feb57a3e2843527b49b9427

  before_save {
    email.downcase!
  }
end