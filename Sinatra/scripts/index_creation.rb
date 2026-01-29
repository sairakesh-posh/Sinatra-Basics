require_relative '../config/elasticsearch'

def create_index_books_v2
  unless ELASTIC_CLIENT.indices.exists?(index: 'books_v2')
    ELASTIC_CLIENT.indices.create(
      index: 'books_v2',
      body: {
        mappings: {
          properties: {
            title: {
              type: "text",
              analyzer: "english",
              fields: {
                keyword: {
                  type: "keyword"
                }
              }
            },
            author:{
              type: "text",
              fields: {
                keyword: {
                  type: "keyword"
                }
              }
            },
            genre: {
              type: "keyword"
            },
            description: {
              type: "text"
            },
            rating:{
              type: "float"
            },
            year: {
              type: "integer"
            }
          }
        }
      }
    )
  end
end

create_index_books_v2