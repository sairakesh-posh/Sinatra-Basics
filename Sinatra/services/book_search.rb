INDEX = 'books_v2'

class BookSearch
  def index(book)
    # puts book.id
    ELASTIC_CLIENT.index(
      index: INDEX,
      id: book.id.to_s,
      body: {
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
      index: INDEX,
      id: id.to_s
    )
  rescue => e
    nil
  end

  def search(pg, query)
    query_clean = query_cleaner(query[:query])
    plain_query = query[:query]
    genres = query[:genre]

    body = {
      from: 15 * (pg-1),
      size: 15,
      query: {
        bool:{
          should:[
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
                description: {query: query_clean, boost:2 }
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
              match:{
                author: { query: plain_query,
                          fuzziness: 2,
                          boost: 3}
              }
            },
            {
              term:{
                "author.keyword" => {
                  value: plain_query,
                  boost: 4
                }
              }
            }
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
      ],
      aggs: {
        genres: {
          terms: {
            field: "genre"
          }
        },
        authors: {
          terms: {
            field: "author.keyword"
          }
        }
      }
    }

    should = body[:query][:bool][:should]
    genres.each do |genre|
      should << {
        term: {
          genre: {
            value: genre,
            case_insensitive: true,
            boost: 5
          }
        }
      }
    end


    begin
      res = ELASTIC_CLIENT.search(
        index: INDEX,
        body: body
      )
      related_id = []
      res['hits']['hits'].each do |hit|
        related_id << hit['_id']
      end
      {
        ids: related_id,
        aggs: res['aggregations'],
        size: res['hits']['total']['value']
      }
    rescue => error
      puts error
      error.to_json
    end
  end

  #Query cleaning is not preferred as it affects the match_phrase working
  def query_cleaner(query)
    stop_words = %w[a an the is was]
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