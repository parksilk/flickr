require 'bcrypt'

class User < ActiveRecord::Base
  has_many :albums
  has_many :photos, :through => :albums

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(user_params)
    user = User.find_by_email(user_params['email'])
    return user if user && (user.password == user_params['password'])
    nil
  end
end
