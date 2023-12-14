Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }, path: '', path_names: { sign_in: 'sign_in', sign_up: 'sign_up' }

  root "tasks#index"

  namespace :account do
    resources :profile, only: %i[index update destroy]
  end

  namespace :admin do
    resources :users, only: %i[ index show update]
  end

  resources :tasks
  resources :categories
end
