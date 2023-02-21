Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users
  get 'static_pages/secret'
  resources :events, only: [:index, :new, :show, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
