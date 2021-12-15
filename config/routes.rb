Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts, :users
  put 'posts/:id/like', to: 'posts#like', as: 'like'
end
