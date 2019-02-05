Types::CartType = GraphQL::ObjectType.define do
  name "Cart"

  field :id, !types.ID
  field :total_cost do
   type !types.Float
   description "The total cost of items in this cart"
   argument :id, types.ID
   resolve -> (obj, args, ctx) {
     Cart.find(args[:id]).total_cost
   }
  end
end
