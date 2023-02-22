Rails.application.routes.draw do
  root "schedules#index"
  resources :books
  devise_for :users
  namespace :admin do
    root "home#index"
    resources :popups
    resources :schedules do
      resources :popups
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
