require 'sinatra'
require_relative 'services/book_service'
require_relative 'repository/database'
require_relative 'controllers/test_controller'
require_relative 'controllers/controller'
require 'json'
require 'mongoid'

Mongoid.load!(
  File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'),
  # ENV['RACK_ENV'] || :development
)

# DB = DataBase.new
SERVICE = Service.new

Controller.set :service, SERVICE

use Controller
