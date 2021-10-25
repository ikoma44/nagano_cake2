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
  end
  
  scope module: :customers do
  get '/customers/unsubscribe' => "customers#unsubscribe"
  get '/customers/withdraw' => "customers#withdraw"
  resources :customers, only:[:show, :edit, :update]
  end
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
end
