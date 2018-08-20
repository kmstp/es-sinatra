require 'sinatra'
require 'sinatra/json'
require_relative '../users'
ENV['RACK_ENV'] ||= 'development'
require_relative '../db/init'
require 'rack/contrib'
require_relative './graphql/schema'

class UsersApi < Sinatra::Base
  use Rack::PostBodyContentTypeParser 
  set :views, File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'
  
  get '/' do
    content_type :html
    erb :graphiql
  end

  post '/graphql' do
    result = UsersApiSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
