Types::CartItemType = GraphQL::ObjectType.define do
  name "CartItem"

  field :id, !types.ID
  field :cart_items do
    type types[Types::ProductType]
    resolve -> (cart_item, args, ctx) {
      cart_item.where(cart_id: Cart.last.id)

    }
  end
  
  field :product do
    type types[Types::ProductType]
    argument :id, !types.ID
    description 'returns the cartItems that are from the most recent cart and have this product'
    resolve -> (cart_item, args, ctx) {
      cart_item.where(cart_id: Cart.last.id, product_id: args[:id])
    }
  end

  #  field :product_id do
#   type types[Types::ProductType]
#   resolve -> (cart_item, args, ctx) {
#     cart_item.where(cart_id: Cart.last.id).product
#   }
#  end
  
  field :quantity, !types.Int
  #field :total_cost do
  #  type !types.Float
  #  description "The total cost of items in this cart"
  #  resolve -> (obj, args, ctx) {
  #    Cart.total_cost
  #  }
  #end  
end
