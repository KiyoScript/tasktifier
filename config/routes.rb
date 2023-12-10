Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }, path: '', path_names: { sign_in: 'sign_in', sign_up: 'sign_up' }

  root "tasks#index"

  namespace :account do
    resources :profile, only: %i[index update destroy]
  end

  resources :tasks
  resources :categories
end
