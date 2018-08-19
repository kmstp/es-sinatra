require 'sinatra'
require_relative '../users'

class UsersApp < Sinatra::Base

  get '/' do
    'It Works!'
  end
end