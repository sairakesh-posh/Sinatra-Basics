require 'sinatra'
require_relative 'services/book_service'
require_relative 'repository/database'
require_relative 'controllers/test_controller'
require_relative 'controllers/controller'
require_relative 'platform/search_helper'
require 'json'
require 'mongoid'
require 'dotenv/load'
require_relative 'config/elasticsearch'

Mongoid.load!(
  File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'),
  ENV['RACK_ENV'] || :development
)

# DB = DataBase.new
SERVICE = Service.new
SEARCH_HELPER = SearchHelper.new(SERVICE)

Controller.set :service, SERVICE
Controller.set :book_search_helper, SEARCH_HELPER

use Controller
