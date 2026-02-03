require 'redis'

CLIENT = Redis.new(host: 'localhost', port: 6379)