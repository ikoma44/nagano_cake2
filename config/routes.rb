Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  namespace :admins do
    resources :items, only:[:show, :index, :new, :edit, :update, :create]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only: [:update]
    get '/' => "homes#top"
  end
  
  scope module: :customers do
  get '/customers/unsubscribe' => "customers#unsubscribe"
  patch '/customers/withdraw' => "customers#withdraw"
  resources :customers, only:[:show, :edit, :update]
  resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  resources :items, only:[:index, :show]
  delete '/cart_items/destroy_all' => "cart_items#destroy_all"
  resources :cart_items, only:[:index, :create, :show, :destroy]
  get '/orders/complete' => "orders#complete"
  post '/orders/confirm' => "orders#confirm"
  resources :orders, only:[:index, :show, :new, :create]
  end
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
end
