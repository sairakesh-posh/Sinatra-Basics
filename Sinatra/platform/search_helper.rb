require_relative '../services/book_search'

class SearchHelper
  def initialize
    @search = BookSearch.new
  end

  def index(book)
    @search.index(book)
  end

  def delete(id)
    @search.delete(id)
  end

  def update(book)
    # @search.delete(id)
    @search.index(book)
  end

  def replace(book)
    @search.delete(book.id)
    @search.index(book)
  end

  def search(pg, query)
    body = {
      query: query,
      genre: genre_parser(query)
    }
    @search.search(pg, body)
  end

  def genre_parser(query)
    genres = ['political', 'classic', 'horror', 'history', 'sci-fi', 'drama','action']
    final = []
    query.split(' ').each do |genre|
      if genres.include?(genre)
        final << genre.capitalize
      end
    end
    final
  end
end