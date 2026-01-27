require_relative '../platform/search_helper'
require_relative '../services/book_service'

class Books_Helper
  def initialize
    @service = Service.new
    @search_helper = SearchHelper.new
  end

  def add_book(book)
    begin
      book_new = @service.add(book)
      @search_helper.index(book_new)
      book_new
    rescue => error
      {err: error}
    end
  end

  def delete_book(book_id)
    begin
      @service.delete(book_id)
      @search_helper.delete(book_id.to_s)
      true
    rescue => error
      error
    end
  end

  def update_book(book_id, book)
    if @service.update_by_id(book_id, book)
      @search_helper.update(@service.find_by_id(book_id))
      @service.find_by_id(book_id)
    else
      false
    end
  end

  def get_books()
    @service.print_all
  end

  def get_book_by_id(id)
    begin
      @service.find_by_id(id)
    rescue => error
      nil
    end
  end

  def search(query)
    ids = @search_helper.search(query)
    @service.find_multiple(ids)
  end
end
