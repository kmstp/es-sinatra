class UserCreated < Sequent::Event
  attrs email: String, encrypted_password: String, created_at: DateTime
end

class PasswordUpdated < Sequent::Event
  attrs encrypted_password: String, updated_at: DateTime
end
