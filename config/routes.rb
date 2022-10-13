Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  root 'users#new'

  resources :messages do
    collection do
      post :confirm
    end
  end
end
