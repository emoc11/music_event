class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :presence=> true, length: { in: 6..20 }, :confirmation => true
  # Pour la validation du password, il vérifie que "password_confirmation = password"
end
