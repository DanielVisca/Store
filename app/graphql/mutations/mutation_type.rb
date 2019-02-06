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

  field :addToCart, !types[Types::CartType] do
    description 'Add a product to a cart'
    argument :cart_id, types.ID, default_value: Cart.last.id
    argument :product_id, !types.ID
    argument :quantity, types.Int, default_value: 1
    resolve ->(obj, args, ctx) {
      #create a line item
      CartItem.create(cart_id: args[:cart_id], 
                      product_id: args[:product_id], 
                      quantity: args[:quantity]
                     )
      CartItem.where(cart_id: Cart.find_by_id(args[:cart_id]))
    }
  end
end
