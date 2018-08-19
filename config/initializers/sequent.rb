require './db/migrations'

Sequent.configure do |config|
  config.migrations_class_name = 'Migrations'

  config.command_handlers = [
    UserCommandHandler.new
  ]

  config.event_handlers = [
    UserProjector.new, UniqueEmailPolicyProjector.new
  ]
end
