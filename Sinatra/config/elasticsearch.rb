require 'dotenv/load'
require 'elasticsearch'

ELASTIC_CLIENT = Elasticsearch::Client.new(
  url: ENV['ELASTICSEARCH_URL'],
  user: ENV['ELASTICSEARCH_USER'],
  password: ENV['ELASTICSEARCH_PASSWORD'],
  transport_options: {
    ssl: { verify: false }
  },
  log: true
)