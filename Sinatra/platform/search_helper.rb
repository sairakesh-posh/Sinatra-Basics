require_relative '../services/book_service'
require_relative '../services/book_search'

class SearchHelper
  def initialize(service)
    @service = service
    @search = BookSearch.new
  end

  def index(book)
    @search.index(book)
  end

  def delete(id)
    @search.delete(id)
  end

  def update(id)
    # @search.delete(id)
    @search.index(@service.find_by_id(id))
  end

  def search(query)
    body = {
      query: query,
      genre: genre_parser(query)
    }
    ids = @search.search(body)
    @service.find_multiple(ids)
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