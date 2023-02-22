Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users
  resources :events, only: [:index, :new, :show, :create]
  resources :users, only: [:new, :show, :edit, :update]
  get 'static_pages/secret'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
