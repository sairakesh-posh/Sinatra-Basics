# require_relative '' '../server'
require 'dotenv/load'      # ✅ FIRST
require 'mongoid'
require 'elasticsearch'

require_relative '../config/elasticsearch'
require_relative '../services/book_search'
require_relative '../models/book_mongo'

puts 'Starting reindex...'


Mongoid.load!(
  File.expand_path('../config/mongoid.yml', __dir__),
  ENV['RACK_ENV'] || :development
)
puts ELASTIC_CLIENT.cluster.health


Book.all.each_with_index do |book, index|
  begin
    BookSearch.index(book)
    puts "Indexed book: #{index+1} with title #{book.title}"
  rescue => e
    puts e.message
  end
end