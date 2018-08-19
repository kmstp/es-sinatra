require_relative '../../spec_helper'
require_relative '../../../app/projectors/user_projector'

describe UserProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:user_projector) { UserProjector.new }
  let(:now) { DateTime.now }
  let(:user_created) { 
    UserCreated.new(
      aggregate_id: aggregate_id, 
      sequence_number: 1,
      email: 'check1@gmail.com',
      encrypted_password: 'dung',
      created_at: now) 
  }

  context UserCreated do
    it 'creates a projection' do
      user_projector.handle_message(user_created)
      expect(UserRecord.count).to eq(1)
      record = UserRecord.first
      expect(record.aggregate_id).to eq(aggregate_id)
    end
  end
end

