class BookSearch
  def index(book)
    # puts book.id
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
    query_clean = query_cleaner(query[:query])
    puts query_clean
    plain_query = query[:query]
    puts plain_query
    genres = query[:genre]

    body = {
      query: {
        bool:{
          # must:{
          #   match_all:{}
          # },
          should:[
            # {
            #   term:{
            #     genre: {value: genres,
            #             case_insensitive: true,
            #             boost: 3}
            #   }
            #
            # },
            {
              match_phrase:{
                title: { query: plain_query,
                         boost: 4 ,
                         slop: 3}
              }
            },
            {
              match:{
                title: {query: query_clean,
                        boost: 2}
              }
            },
            {
              match:{
                description: {query: plain_query, boost:2 }
              }
            },
            {
              match_phrase:{
                author: {query: plain_query,
                         boost: 4,
                         slop: 3 }
              }
            },
            {
              term:{
                author: { value: plain_query,
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
          minimum_should_match: 1
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

    should = body[:query][:bool][:should]
    genres.each do |genre|
      should << {
        term: {
          genre: {
            value: genre,
            case_insensitive: true,
            boost: 3
          }
        }
      }
    end


    begin
      res = ELASTIC_CLIENT.search(
        index: 'books',
        body: body
      )
      related_id = []
      res['hits']['hits'].each do |hit|
        related_id << hit['_id']
      end
      related_id
    rescue => error
      puts error
      error.to_json
    end
  end


  #Query cleaning is not preferred as it affects the match_phrase working
  def query_cleaner(query)
    stop_words = ['a', 'an', 'the', 'is', 'was']
    filtered_query = ''
    query.split(' ').each do |word|
      if stop_words.include?(word)
        next
      else
        filtered_query += word + ' '
      end
    end
    filtered_query
  end
end