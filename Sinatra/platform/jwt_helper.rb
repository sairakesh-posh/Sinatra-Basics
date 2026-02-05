require 'jwt'
require 'dotenv/load'

module JWT_Helper
  SECRET = ENV['JWT_SECRET']
  def create_token(user)
    JWT.encode(
      {
        user_name: user['username'],
        role: user['role'],
        exp: Time.now.to_i + 24 * 60 * 60
      },
      SECRET,
      'HS256',
    )
  end

  def decode_token
    begin
      token = request.env['HTTP_AUTHORIZATION'].split(' ').last
      data = JWT.decode(token, SECRET, true, algorithm: 'HS256')[0]
    rescue JWT::ExpiredSignature
      halt 401, {err: "Token has expired"}.to_json
    rescue => error
      nil
    end
  end

  def authenticated?
    user = decode_token
    if user.nil?
      halt 401, {err:  "Authentication failed"}.to_json
    end
    user['user_name']
  end

  def authenticated_admin?
    user = decode_token
    if user.nil?
      halt 401, {err:  "Authentication failed"}.to_json
    elsif user['role'] != 'admin'
      halt 403, {err: "Action not allowed"}.to_json
    end
  end
end