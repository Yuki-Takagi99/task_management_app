Rails.application.routes.draw do
  get 'users/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
end
