require 'mongoid'

class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :author, type: String
  field :pg, type: Integer
  field :copies, type: Integer
end
