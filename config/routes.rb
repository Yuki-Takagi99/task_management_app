Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
