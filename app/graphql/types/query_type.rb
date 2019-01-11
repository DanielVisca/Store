Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allProducts, !types[Types::ProductType] do
    description "All the products in this store"
    resolve -> (obj, args, ctx) { Product.all }
  end
end
