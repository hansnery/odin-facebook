Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts, :users
  put 'posts/:id/like', to: 'posts#like', as: 'like'
  put 'posts/:id/dislike', to: 'posts#dislike', as: 'dislike'
  # put 'users/:id/friend_request', to: 'users#friend_request', as: 'friend_request'
  # put 'users/:id/cancel_friend_request', to: 'users#cancel_friend_request', as: 'cancel_friend_request'
end
