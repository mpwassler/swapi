Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :catagories, param: :slug
  resources :products, param: :slug
  resources :product_variations
  resources :orders
  resources :order_items
  resources :users
end
