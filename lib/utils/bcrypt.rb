require 'bcrypt'

module Utils
  def hash_password(password)
    BCrypt::Password.create(password)    
  end

  def check_password?(password, expected)
    unhashed = BCrypt::Password.new(expected)
    password == unhashed
  end

  module_function :hash_password, :check_password?
end
