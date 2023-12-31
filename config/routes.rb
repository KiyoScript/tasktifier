Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }, path: '', path_names: { sign_in: 'sign_in', sign_up: 'sign_up' }

  root "tasks#index"
  resources :account_deactivation, only: %i[index]
  namespace :account do
    resources :profile, only: %i[index update destroy]
    resources :statuses, only: %i[update]
  end

  namespace :admin do
    resources :users, only: %i[index show update]
    resources :statuses, only: %i[update]
  end

  resources :tasks
  resources :categories

  resources :privacy_policies

  resources :mark_as_done, only: %i[update]
end
