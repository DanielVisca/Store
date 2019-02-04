Rails.application.routes.draw do
  
  resources :cart_items
  resources :carts
  namespace :admin do
    resources :products
    get 'products/:id/create', to: 'products#create'

  end
 
  resources :products
  resources :carts

  get 'products/:id/add_to_cart', to: 'products#add_to_cart', as: :add_to_cart
  get 'carts/create', to: "carts#create", as: :cart_create
  get 'carts/:id/purchase', to: "carts#purchase", as: :purchase

  if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
