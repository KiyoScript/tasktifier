Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'sign_in', sign_up: 'sign_up'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"
  resources :tasks
  resources :categories
end
