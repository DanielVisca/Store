PurchaseProductMutation = GraphQL::Relay::Mutation.define do
  name "PurchaseProduct"

  input_field :id, !type.ID

  return_field :product, ProductType

  resolve ->(inputs, ctx) {
    product = Product.find_by_id(inputs[:id])
    inventory_count = product.inventory_count
    product.update(inventory_count: inventory_count-1)
    {product: product}
  }
end
