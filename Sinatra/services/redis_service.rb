require_relative '../config/redis'

class RedisService
  def initialize
    @client = CLIENT
  end

  def add_to_cache(username, book_id)
    @client.sadd("users:#{username}:recently_viewed", book_id)
  end

  def check_cache(username, book_id)
    @client.sismember("users:#{username}:recently_viewed", book_id)
  end

  def get_all_books(username)
    @client.smembers("users:#{username}:recently_viewed")
  end
end