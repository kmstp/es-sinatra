require 'graphql'
require_relative './types/query'

UsersApiSchema = GraphQL::Schema.define do
  query QueryType
end
