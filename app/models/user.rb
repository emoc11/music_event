require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  validates :login, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true, confirmation: true, :on => :create

  before_save {
    email.downcase!
  }
end