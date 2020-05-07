Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root to: 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
