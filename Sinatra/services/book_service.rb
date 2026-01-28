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
    # begin
      book = Book.find_by(id: id)
      book.destroy
    #   true
    # rescue => error
    #   puts error
    #   false
    # end
  end

  def print_all
    Book.all
  end

  def find_by_id(id)
    begin
      Book.find_by(id: id)
    rescue => error
      nil
    end

  end

  # def get_id
  #   @db.get_id
  # end

  def update_by_id(book_id, book)
    begin
      book_old = Book.find_by(id: book_id)
      book_old.update(book)
      true
    rescue => error
      false
    end
  end

  def replace(book_id, book_new)
    book_old = find_by_id(book_id)
    if book_old.nil?
      raise "No Book present with given ID"
    else
      # required = ['title', 'author']
      # missing = required - book_new.keys.map(&:to_s)
      # raise "Missing fields: #{missing.join(', ')}" unless missing.empty?
        temp = Book.new(book_new)
        # temp.assign_attributes(book_new)
        if temp.valid?
          protected = ['_id' ,'created_at' ,'updated_at']
          fields_to_clear = Book.fields.keys - protected
          fields_to_clear.each { |f| book_old.unset(f) }
          book_old.assign_attributes(book_new)
          book_old.save!
          book_old
        else
          puts temp.id
          puts book_old.id
          puts book_new
          raise temp.errors.full_messages[0]
      end
    end
  end

  def test
    Book.find_by(title: "The Hobbit")
  end

  def find_multiple(related_ids)
    related_books = []
    related_ids.each do |id|
        book = find_by_id(id)
        if book.nil?
          puts "Book with #{id} not found"
          next
        end
        related_books << book
    end
    related_books
  end
end