class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :presence=> true, :confirmation => true #password_confirmation attr
  #validates_length_of :password, :in => 6..20, :on => :create # A CORRIGER --
end
