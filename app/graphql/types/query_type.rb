Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :product do
    type Types::ProductType
    argument :id, !types.ID
    resolve -> (obj, args,ctx) {
      Product.find(args[:id])
    }
  end

  field :allProducts, !types[Types::ProductType] do
    description "All the products in this store"
    resolve -> (obj, args, ctx) { Product.all }
  end

#  field :Product do
#    type Types::ProductType
#    argument :id, !typesID
#    description 'Find a product by ID'
#    resolve ->(obj, args, ctx) {
#      Product.find_by(id: args[:id])
#    }
#  end

  field :allCarts, !types[Types::CartType] do
    description "All carts made in this store"
    resolve -> (obj, args, ctx) { Cart.all }
  end

#  field :Cart do
#    type Types::CartItemType
#    argument :id, !types.ID
#    description 'Find a cart by ID'
#    resolve -> (obj, args, ctx) {
#      CartItem.where(cart: args[:id])
#    }
#  end
end
