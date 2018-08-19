require_relative '../records/unique_email_policy_record'
require_relative '../../lib/user/events'

class UniqueEmailPolicyProjector < Sequent::Projector
  manages_tables UniqueEmailPolicyRecord

  on UserCreated do |event|
    create_record(UniqueEmailPolicyRecord, 
      email: event.email
    )
  end
end
