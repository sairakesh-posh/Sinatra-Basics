require 'sinatra'
require_relative 'services/book_service'
require_relative 'repository/database'
require_relative 'controllers/test_controller'
require_relative 'controllers/controller'
require 'json'


DB = DataBase.new
SERVICE = Service.new(DB)

Controller.set :service, SERVICE

use Controller
