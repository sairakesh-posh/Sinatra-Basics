require 'mongoid'
require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name, :type => String
  field :username, :type => String
  field :password_hash, :type => String
  field :role, :type => String

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :role, :presence => true

  def password=(pass)
    self.password_hash = Password.create(pass)
  end

  def verify(pass)
    Password.new(password_hash) == pass
  end
end