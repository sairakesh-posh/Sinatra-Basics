class BookSearch
  def initialize(book_service)
    @book_service = book_service
  end
  def index(book)
    ELASTIC_CLIENT.index(
      index: 'books',
      id: book.id.to_s,
      body: {
        id: book.id.to_s,
        title: book.title,
        author: book.author,
        genre: book.genre,
        year: book.year,
        rating: book.rating,
        description: book.description
      }
    )
  end

  def delete(id)
    ELASTIC_CLIENT.delete(
      index: 'books',
      id: id.to_s
    )
  rescue => e
    nil
  end

  def search(query)
    puts query
    begin
      res = ELASTIC_CLIENT.search(
        index: 'books',
        body: {
          query: {
            bool:{
              must:{
                match_all:{}
              },
              should:[
                {
                  term:{
                    genre: {value: query,
                            case_insensitive: true,
                             boost: 3 }
                  }
                },
                {
                  match_phrase:{
                    title: { query: query,
                             boost: 4 ,
                             slop: 3}
                  }
                },
                {
                  match:{
                    title: {query: query,
                             boost: 2}
                  }
                },
                {
                  match:{
                    description: {query: query, boost:2 }
                  }
                },
                {
                  match_phrase:{
                    author: {query: query,
                              boost: 4,
                             slop: 3 }
                  }
                },
                {
                  term:{
                    author: { value: query,
                              case_insensitive: true ,
                              boost: 1}
                  }
                },
                # {
                #   term:{
                #     genre: {
                #       value: "Action",
                #       # boost: 2
                #     }
                #   },
                # },
                # {
                #   term:{
                #     genre: {
                #       value: "History",
                #       # boost: 1
                #     }
                #   }
                # }
              ],
              # minimum_should_match: 1
            }
          },
          sort:[
            {
              _score: "desc"
            },
            {
              rating: {
                order: "desc"
              }
            }
          ]
        }
      )
      related_id = []
      res['hits']['hits'].each do |hit|
        related_id << hit['_id']
      end
      @book_service.find_multiple(related_id)
    rescue => error
      puts error
      error.to_json
    end
  end


  # Query cleaning is not preferred as it affects the match_phrase working
  # def query_cleaner(query)
  #   stop_words = ['a', 'an', 'the', 'is', 'was']
  #   filtered_query = ''
  #   query.split(' ').each do |word|
  #     if stop_words.include?(word)
  #       next
  #     else
  #       filtered_query += word + ' '
  #     end
  #   end
  #   filtered_query
  # end
end