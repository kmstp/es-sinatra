ENV['RACK_ENV'] ||= 'development'

require './users'
require 'sequent/rake/migration_tasks'

Sequent::Rake::MigrationTasks.new.register_tasks!

task "sequent:migrate:init" => [:db_connect]

task 'db:init', :db_connect do
  load('db/sequent_schema.rb')
end

task "db_connect" do
  Sequent::Support::Database.connect!(ENV['RACK_ENV'])
end
