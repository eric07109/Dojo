Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "posts#index"

  resources :posts do
  	resources :comments, shallow: true
  end

  resources :friendships, only: [:create, :destroy, :update]

end
