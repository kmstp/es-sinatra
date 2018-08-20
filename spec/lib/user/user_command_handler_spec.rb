require_relative '../../spec_helper'
require_relative '../../../lib/user'
require_relative '../../../lib/utils/bcrypt'

describe UserCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:now) { DateTime.now }
  let(:password) { hash_password('Dung213') }
  let(:new_password) { hash_password('Dung1234') }
  let(:new_email) { 'checkraiser11@gmai.com' }

  before :each do
    Sequent.configuration.command_handlers = [UserCommandHandler.new]
  end

  it 'creates a user' do
    when_command CreateUser.new(
      aggregate_id: aggregate_id, 
      email: new_email, 
      encrypted_password: password,
      created_at: now
    )
    then_events(
      UserCreated.new(
        aggregate_id: aggregate_id, 
        sequence_number: 1, 
        email: new_email, 
        encrypted_password: password, 
        created_at: now
      )
    )
  end

  it 'validates uniqueness of email' do
    given_events UserCreated.new(
      aggregate_id: aggregate_id, 
      sequence_number: 1, 
      email: new_email, 
      encrypted_password: password, 
      created_at: now
    )
    create_user = CreateUser.new(
      aggregate_id: Sequent.new_uuid, 
      email: new_email, 
      encrypted_password: password, 
    )
    expect {
      when_command(create_user)
    }.to raise_error(Sequent::Core::EventPublisher::PublishEventError)
  end

  it 'updates password' do
    given_events UserCreated.new(
      aggregate_id: aggregate_id, 
      sequence_number: 1, 
      email: new_email, 
      encrypted_password: password, 
      created_at: now
    )
    when_command UpdatePassword.new(
      aggregate_id: aggregate_id,
      encrypted_password: new_password,
      created_at: now
    )
    then_events(
      PasswordUpdatedV2.new(
        aggregate_id: aggregate_id, 
        sequence_number: 2, 
        encrypted_password: new_password, 
        created_at: now
      )
    )
  end
end
