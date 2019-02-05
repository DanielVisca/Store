Types::CartType = GraphQL::ObjectType.define do
  name "Cart"

  field :id, !types.ID
  field :total_cost, !types.Float
end
