Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  
  field :purchaseProduct, Types::ProductType do
    description 'Purchase a product given an ID'
    argument :id, !types.ID
    resolve ->(obj, args, ctx){
      product = Product.find_by_id(args[:id])
      inventory_count = product.inventory_count
      if inventory_count == 0
        product
      else
        product.update(inventory_count: inventory_count-1)
        product
      end
    }
  end

  field :purchaseCart, !types[Types::CartType] do
    description 'Purchase every product in a cart given the cart ID'
    argument :id, !types.ID
    resolve ->(obj,args, ctx) {
      cart = CartItem.where(cart_id: Cart.find_by_id(args[:id]))
      cart.each do |item|
        product = Product.find_by_id(item.product_id)
        inventory_count = product.inventory_count
        if inventory_count == 0
          next
        else
          product.update(inventory_count: inventory_count -1)
        end
      end
    cart
    }
  end
end
