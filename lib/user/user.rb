require 'set'

class User < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply UserCreated, 
      email: command.email, 
      encrypted_password: command.encrypted_password, 
      created_at: command.created_at
  end

  def update_password(command)
    apply PasswordUpdated, encrypted_password: command.encrypted_password, updated_at: command.updated_at
  end

  on UserCreated do |event|    
    @email = event.email
    @encrypted_password = event.encrypted_password
    @created_at = event.created_at
  end

  on PasswordUpdated do |event|
    @encrypted_password = event.encrypted_password
    @password_updated_at = event.updated_at
  end
end
