class BookSearch
  def self.index(book)
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

  def self.delete(id)
    ELASTIC_CLIENT.delete(
      index: 'books',
      id: id.to_s
    )
  rescue => e
    nil
  end

  def self.search(query)
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
                    genre: { value: query,
                             case_insensitive: true,
                             boost: 2}
                  }
                },
                {
                  match:{
                    title: {query: query,
                             boost: 4 }
                  }
                },
                {
                  match:{
                    description: query,
                  }
                },
                {
                  term:{
                    author: { value: query,
                              case_insensitive: true ,
                              boost: 3}
                  }
                },
                {
                  term:{
                    genre: {
                      value: "Action",
                      boost: 2
                    }
                  },
                },
                {
                  term:{
                    genre: {
                      value: "History",
                      boost: 1
                    }
                  }
                }
              ],
              # minimum_should_match: 1
            }
          },
          # sort:[
          #   {
          #     rating: {
          #       order: "desc"
          #     }
          #   }
          # ]
        }
      )
      res['hits']['hits'].to_json
    rescue => error
      puts error
      error.to_json
    end
  end
end