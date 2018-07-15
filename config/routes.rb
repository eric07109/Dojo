Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "posts#index"

  resources :users, only: [:show, :edit, :update] do 
    member do 
      patch :accept_friendship
    end
  end

  resources :posts do
  	resources :comments, shallow: true
  	member do 
  		post :add_collection
  		delete :remove_collection
    end
    collection do
      get :feeds
    end
  end

  resources :friendships, only: [:create, :destroy]

  scope '/admin' do
    resources :categories, only: [:index, :create, :update, :destroy]
    patch '/users/:id', to: 'users#update_admin', as: :update_admin
    get '/users', to: 'users#index'
    # resources :users, only: [:index, :update]
  end

  namespace :api, defaults: {format: :json} do
    namespace :vi do
      resources :posts, only: [:index, :show, :create, :update, :destroy]
    end
  end

end
