Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  get '/401' => 'errors#not_authorized'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :catagory
  resources :product
  resources :product_variation
  resources :order
  resources :order_item
  resources :user
end
