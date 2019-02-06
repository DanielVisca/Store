Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  
  field :purchaseProduct, Types::ProductType do
    description 'Purchase a product given an ID'
    argument :id, !types.ID
    resolve ->(obj, args, ctx){
      product = Product.find_by_id(args[:id])
      product.update(inventory_count: 0)
      product
    }
  end
end
