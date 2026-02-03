require_relative '../models/user_model'
require_relative '../platform/jwt_helper'

class UserService
  def add_new_user(data)

    if User.exists?(username: data["username"])
      raise "Username not available"
    end
    if data['password'].nil? || data['password'].length < 6
      raise "Enter a valid password"
    end
    user = User.create!(name: data['name'] ,username: data["username"], password: data["password"], role: data['role'])
    user
  end

  def authenticate(data)
    user = User.find_by(username: data["username"]) rescue nil
    if user.nil? || (user.verify(data["password"]) == false)
      raise "Invalid username or password"
    end
    user
  end
end