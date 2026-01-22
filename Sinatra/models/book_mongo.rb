require 'mongoid'

class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :author, type: String
  field :pg, type: Integer
  field :copies, type: Integer

  field :year, type: Integer
  field :genre, type: String
  field :rating, type: Float
  field :description, type: String

  validates :title, :presence => true
  validates :author, :presence => true

end
