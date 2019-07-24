Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  root 'tasks#index'

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  # 管理画面のルーティング
  namespace :admin do
    resources :users
  end

  resources :lavels
end
