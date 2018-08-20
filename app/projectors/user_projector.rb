require_relative '../records/user_record'
require_relative '../../lib/user/events'

class UserProjector < Sequent::Projector
  manages_tables UserRecord

  on UserCreated do |event|
    create_record(UserRecord, 
      aggregate_id: event.aggregate_id,
      email: event.email, 
      encrypted_password: event.encrypted_password, 
      created_at: event.created_at
    )
  end

  on PasswordUpdated do |event|
    update_all_records(
      UserRecord,
      event.attributes.slice(:aggregate_id),
      event.attributes.slice(:encrypted_password, :updated_at)
    )
  end

  on PasswordUpdatedV2 do |event|
    update_all_records(
      UserRecord,
      event.attributes.slice(:aggregate_id),
      event.attributes.slice(:encrypted_password, :created_at)
    )
  end
end
