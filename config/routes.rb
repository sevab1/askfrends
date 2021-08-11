Rails.application.routes.draw do
  resources :users
  resources :users
  resources :questions
  root to: 'users#index'
  get 'users/index'
  get 'users/new'
  get 'users/edit'
  get 'users/show'
 get 'show' => 'users#show'
end
