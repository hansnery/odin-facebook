Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts, :users
  put 'posts/:id/like', to: 'posts#like', as: 'like'
  put 'posts/:id/dislike', to: 'posts#dislike', as: 'dislike'
  put 'users/:id/befriend', to: 'users#befriend', as: 'befriend'
  put 'users/:id/break_friendship', to: 'users#break_friendship', as: 'break_friendship'
end
