Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:show, :edit, :update]
  get 'unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'withdraw/:id' => 'users#withdraw', as: 'withdraw_customer'

  resources :schedules, only: [:index, :new, :show, :edit, :create, :update, :destroy]

  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
  end

  resources :activities, only: [:index, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
