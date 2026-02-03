require_relative '../platform/search_helper'
require_relative '../services/book_service'
require_relative '../services/redis_service'

class Books_Flow
  def initialize
    @service = Service.new
    @search_helper = SearchHelper.new
    @redis_service = RedisService.new
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

  def update_book(book)
    begin
      book_id = book['id']
    rescue => error
      return false
    end
    if @service.update_by_id(book_id, book)
      @search_helper.update(@service.find_by_id(book_id))
      @service.find_by_id(book_id)
    else
      false
    end
  end

  def replace_book(book)
    begin
      book_id = book['id']
    rescue => error
      return false
    end
    begin
      book_updated = @service.replace(book_id, book)
      @search_helper.replace(book_updated)
      book_updated
    rescue => error
      { err: error }
    end
  end

  def get_books(pg)
    @service.print_all(pg)
  end

  def get_book_by_id(username, id)
    begin
      book = @service.find_by_id(id)
      puts book[:id]
      @redis_service.add_to_cache(username, book[:id].to_s)
      book
    rescue => error
      puts error
      nil
    end
  end

  def search(pg, query, username)
    res = @search_helper.search(pg, query)
    ids = res[:ids]
    aggregations = res[:aggs]
    books = @service.find_multiple(ids)
    books << aggregations
    viewed = @redis_service.get_all_books(username)

    viewed.each do |id|
      index = ids.index(id)
      if index.nil?
        next
      end
      books[index]['viewed'] = true
    end
    # books.each_with_index do |book, index|
    #   if book['id'].nil?
    #     next
    #   end
    #   if viewed.include?(book['id'].to_s)
    #     books[index]['viewed'] = true
    #   end
    # end
    books
  end
end
