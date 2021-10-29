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
  end
  
  scope module: :customers do
  resources :customers, only:[:show, :edit, :update]
  get '/customers/unsubscribe' => "customers#unsubscribe"
  patch '/customers/withdraw' => "customers#withdraw"
  resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  resources :items, only:[:index, :show]
  resources :cart_items, only:[:index, :create, :show, :destroy]
  delete '/cart_items/destroy_all' => "cart_items#destroy_all"
  resources :orders, only:[:index, :show, :new, :create]
  post '/orders/confirm' => "orders#confirm"
  get '/orders/complete' => "orders#complete"
  end
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
end
