class DataBase
  def initialize
    @data = []
    @count = 1
  end
  @instance = nil

  def self.get_instance
    if @instance.nil?
      @instance = DataBase.new
    end
    @instance
  end

  def add_book(book)
    @data << (book)
    @count += 1
  end

  def delete_by_id(id)
    book = find_by_id(id)
    if book.nil?
      false
    else
      @data.delete(book)
      true
    end
  end

  def find_by_id(id)
    @data.each do |val|
      if val.id == id
        return val
      end
    end
    nil
  end

  def print_data
    @data
  end

  def get_id
    @count
  end

  def update_by_id(id, book)
    book_old = find_by_id(id)
    if book_old.nil?
      nil
    else
      book_old.name = book.name
      book_old.ph_no = book.ph_no
      book_old.email = book.email
      book_old.age = book.age
      book_old
    end

  end
end
