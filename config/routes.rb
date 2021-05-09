Rails.application.routes.draw do

  root 'posts#index'
  get 'invitations/update'
  get 'invitations/create'
  get 'invitations/destroy'
  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
