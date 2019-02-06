Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  # TODO: Remove me
#  field :testField, types.String do
#    description "An example field added by the generator"
#    resolve ->(obj, args, ctx) {
#      "Hello World!"
#    }
#  end

#  field :create_product, mutation: Mutations::CreateProduct
  field :purchaseProduct, field: PurchaseProduct.field
end
