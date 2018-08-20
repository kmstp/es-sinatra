require 'graphql'
module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'
    description 'Resembles a User Object Type'
    field :id, !types.ID
    field :email, types.String
  end
end
