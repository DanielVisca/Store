Types::CartItemType = GraphQL::ObjectType.define do
  name "CartItem"

  field :id, !types.ID
  field :cart_items do
    type types[Types::ProductType]
    resolve -> (cart_item, args, ctx) {
      cart_item.where(cart_id: Cart.last.id)
    }
  end
  field :products do
    type types[Types::ProductType]
    resolve -> (cart_item, args, ctx) {
      cart_item.where(cart_id: Cart.last.id).product_id
    }
  end
  field :cart_id, !types.ID
  field :quantity, !types.Int   
end
