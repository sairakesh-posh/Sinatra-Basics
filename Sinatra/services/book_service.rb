require_relative '../models/book_mongo'

class Service
  # @service = nil
  # def initialize(database)
  #   @db = database
  # end

  # def initialize(db)
  #   @db = db
  # end

  # def self.get_instance
  #   if @service.nil?
  #     @service = Service.new
  #   end
  #   @service
  # end

  def add(book)
    Book.create!(book)
  end

  def delete(id)
    begin
      book = Book.find_by(_id: id)
      book.destroy
      true
    rescue => error
      false
    end
  end

  def print_all
    Book.all
  end

  def find_by_id(id)
    begin
      Book.find_by(_id: id)
    rescue => error
      nil
    end

  end

  # def get_id
  #   @db.get_id
  # end

  def update_by_id(book_id, book)
    begin
      book_old = Book.find_by(_id: book_id)
      book_old.update(book)
      true
    rescue => error
      false
    end
  end
end