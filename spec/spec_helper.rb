require 'bundler/setup'
Bundler.setup
ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'sequent/test'
require 'database_cleaner'

require_relative '../users'
require_relative '../app/api.rb'
require_relative '../db/init'
require_relative '../lib/utils/bcrypt'

module RSpecMixin
  include Rack::Test::Methods
  def app() UsersApi end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Sequent::Test::CommandHandlerHelpers
  config.include Utils

  config.around do |example|
    Sequent.configuration.aggregate_repository.clear
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
