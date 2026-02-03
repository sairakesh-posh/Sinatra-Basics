# require_relative '' '../server'
require 'dotenv/load'
require 'mongoid'
require 'elasticsearch'
require 'json'

require_relative '../config/elasticsearch'
require_relative '../services/book_search'
require_relative '../models/book_mongo'

puts 'Starting reindex...'


Mongoid.load!(
  File.expand_path('../config/mongoid.yml', __dir__),
  ENV['RACK_ENV'] || :development
)
puts ELASTIC_CLIENT.cluster.health


BOOKS_JSON_PATH = File.expand_path('../dataset/data.json', __dir__)

bs = BookSearch.new

books_data = JSON.parse(File.read(BOOKS_JSON_PATH))
puts "Loaded #{books_data.size} books from JSON"


# ---------- STEP 2: Insert into MongoDB ----------
books_data.each_with_index do |data, index|
  begin
    book = Book.create!(
      title: data['title'],
      author: data['author'],
      pg: data['pg'],
      copies: data['copies'],
      year: data['year'],
      genre: data['genre'],
      rating: data['rating'],
      description: data['description']
    )

    puts "Saved to MongoDB: #{index + 1} - #{book.title}"
  rescue => e
    puts "MongoDB insert failed (#{index + 1}): #{e.message}"
  end
end

puts "MongoDB insert completed"


Book.all.each_with_index do |book, index|
  begin
    bs.index(book)
    puts "Indexed book: #{index+1} with title #{book.title}"
  rescue => e
    puts e.message
  end
end