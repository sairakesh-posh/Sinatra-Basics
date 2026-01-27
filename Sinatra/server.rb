require 'sinatra'
require 'json'
require 'mongoid'
require 'dotenv/load'
require_relative 'config/elasticsearch'
require_relative 'controllers/controller'

Mongoid.load!(
  File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'),
  ENV['RACK_ENV'] || :development
)

use Controller
