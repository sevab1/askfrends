Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:destroy]
  resources :questions, except: [:show, :new, :index]
  root to: 'users#index'

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
