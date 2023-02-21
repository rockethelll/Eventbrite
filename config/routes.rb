Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users
  resources :events, only: [:index, :new, :show, :create]
  resources :users, only: [:new, :show, :edit, :update]
  get 'static_pages/secret'
  
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
