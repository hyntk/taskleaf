Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  root 'tasks#index'

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
