class User < ActiveRecord::Base
  has_many :party_users
  has_many :parties, :through => :party_users
  has_secure_password

  validates :login, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :presence=> true, length: { in: 6..20 }, :confirmation => true
  # Pour la validation du password, il vérifie que "password_confirmation = password"

  def self.authenticate(login_or_email="", connexion_password="")
    if  EMAIL_REGEX.match(login_or_email)
      user = User.find_by_email(login_or_email)
    else
      user = User.find_by_username(login_or_email)
    end
    if user && user.match_password(connexion_password)
      return user
    else
      return false
    end
  end
  def match_password(connexion_password="")
    encrypted_password == BCrypt::Engine.hash_secret(connexion_password, salt)
  end
end
