Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    resources :users, only: [:show, :edit, :update]
    get 'unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'withdraw/:id' => 'users#withdraw', as: 'withdraw_user'
  end

  resources :schedules, only: [:index, :new, :show, :edit, :create, :update, :destroy]

  resources :post_blogs, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    get 'search', on: :collection
    get "search_tag", on: :collection
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :update, :destroy]
  end

  resources :activities, only: [:index, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
