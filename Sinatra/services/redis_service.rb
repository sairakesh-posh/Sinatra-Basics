require_relative '../config/redis'

class RedisService
  def initialize
    @client = CLIENT
  end

  def add_to_cache(username, book_id)
    @client.zadd("users:#{username}:recently_viewed", Time.now.to_i , book_id)
  end

  def refresh_cache(username)
    @client.zremrangebyscore("users:#{username}:recently_viewed", "0", (Time.now.to_i - 60*60).to_s)
  end

  def check_cache(username, book_id)
    @client.zmscore("users:#{username}:recently_viewed", book_id)
  end

  def get_all_books(username)
    @client.smembers("users:#{username}:recently_viewed")
  end
end