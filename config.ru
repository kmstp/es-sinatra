ENV['RACK_ENV'] ||= 'development'
db_config = Sequent::Support::Database.read_config(ENV['RACK_ENV'])
Sequent::Support::Database.establish_connection(db_config)
require './app/app'
run UsersApp