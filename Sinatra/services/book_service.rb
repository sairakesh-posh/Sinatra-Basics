require_relative '../repository/database'

class Service
  # @service = nil
  # def initialize(database)
  #   @db = database
  # end

  def initialize(db)
    @db = db
  end

  # def self.get_instance
  #   if @service.nil?
  #     @service = Service.new
  #   end
  #   @service
  # end

  def add(book)
    @db.add_book(book)
  end

  def delete(id)
    if @db.delete_by_id(id) ==  true
      "Book is successfully deleted!"
    else
      "Please enter a valid book id"
    end
  end

  def print_all
    @db.print_data
  end

  def find_by_id(id)
    @db.find_by_id(id)
  end

  def get_id
    @db.get_id
  end

  def update_by_id(book_id, book)
    if @db.update_by_id(book_id, book).nil?
      false
    else
      true
    end
  end
end