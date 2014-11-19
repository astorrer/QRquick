Rails.application.routes.draw do
  resources :quick_codes

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
