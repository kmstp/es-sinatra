require_relative '../../spec_helper'
require_relative '../../../lib/user'

describe UserCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:now) { DateTime.now }

  before :each do
    Sequent.configuration.command_handlers = [UserCommandHandler.new]
  end

  it 'creates a user' do
    when_command CreateUser.new(aggregate_id: aggregate_id, 
      email: 'checkraiser11@gmail.com', 
      encrypted_password: 'Dung123', 
      created_at: now
    )
    then_events(
      UserCreated.new(aggregate_id: aggregate_id, sequence_number: 1, 
        email: 'checkraiser11@gmail.com', 
        encrypted_password: 'Dung123', 
        created_at: now
      )
    )
  end

  it 'validates uniqueness of email' do
    email = 'checkraiser11@gmail.com'
    given_events UserCreated.new(
      aggregate_id: aggregate_id, sequence_number: 1, 
      email: email, 
      encrypted_password: 'Dung123', 
      created_at: now
    )
    create_user = CreateUser.new(
      aggregate_id: Sequent.new_uuid, 
      email: email, 
      encrypted_password: 'Dung123', 
      created_at: now
    )
    expect {
      when_command(create_user)
    }.to raise_error(Sequent::Core::EventPublisher::PublishEventError)
  end

  it 'updates password' do
    given_events UserCreated.new(
      aggregate_id: aggregate_id, sequence_number: 1, 
      email: 'checkraiser11@gmail.com', 
      encrypted_password: 'Dung123', 
      created_at: now
    )
    when_command UpdatePassword.new(aggregate_id: aggregate_id,
      encrypted_password: 'Dung1234',
      updated_at: now
    )
    then_events(
      PasswordUpdated.new(aggregate_id: aggregate_id, sequence_number: 2, encrypted_password: 'Dung1234', updated_at: now)
    )
  end

end

