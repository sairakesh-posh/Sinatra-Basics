require 'sinatra'
require_relative 'controllers/test_controller'
# require_relative 'repository/repository'
require_relative 'controllers/controller'
# require_relative 'models/book'
# require_relative 'services/book_service'


DB = DataBase.new
SERVICE = Service.new(DB)


# Controller.setter(SERVICE)

use Controller