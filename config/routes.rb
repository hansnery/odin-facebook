Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts, :users
  put 'posts/:id/like', to: 'posts#like', as: 'like'
  put 'posts/:id/dislike', to: 'posts#dislike', as: 'dislike'
end
