Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "posts#index"

  resources :users

  resources :posts do
  	resources :comments, shallow: true
  	member do 
  		post :add_collection
  		delete :remove_collection
  	end
  end

  resources :friendships, only: [:create, :destroy, :update]

end
