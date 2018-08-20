db_config = Sequent::Support::Database.read_config(ENV['RACK_ENV'])
Sequent::Support::Database.establish_connection(db_config)

if (ENV['RACK_ENV'] == 'test')
  Sequent::Support::Database.drop_schema!(Sequent.configuration.view_schema_name)

  Sequent::Migrations::ViewSchema.new(db_config: db_config).create_view_tables
  Sequent.configuration.event_store = Sequent::Test::CommandHandlerHelpers::FakeEventStore.new
end