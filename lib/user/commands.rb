class CreateUser < Sequent::Command
  attrs email: String, encrypted_password: String, created_at: DateTime
  validates_presence_of :email, :encrypted_password, :created_at
end

class UpdatePassword < Sequent::Command
  attrs encrypted_password: String, created_at: DateTime
  validates_presence_of :encrypted_password, :created_at
end
