require 'redis'
require_relative '../config/redis'

# redis.set("name01", "Rakesh")
puts CLIENT.lrange("list:1", 0, -1)