Types::CartItemType = GraphQL::ObjectType.define do
  name "CartItem"

  field :id, !types.ID
  field :products do
    type types[ProductType]
    argument :size, types.Int, default_value: 10
    resolve -> (cart_item, args, ctx) {
      cart_item.products.limit(args[:size])
    }
  end
  field :cart_id, !types.ID
  field :quantity, !types.Int   
end
