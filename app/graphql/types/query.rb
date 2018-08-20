require 'graphql'
require_relative 'user_types'

QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"
  field :users, types[Types::UserType] do
    description "Get a list of users"
    resolve ->(_obj, _args, _ctx) {
      UserRecord.all
    }
  end
end
