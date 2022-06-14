Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts, :users
  resources :posts do
    resources :comments, module: :posts
  end
  put 'posts/:id/like', to: 'posts#like', as: 'like'
  put 'posts/:id/dislike', to: 'posts#dislike', as: 'dislike'
  # put 'posts/:id/post_comments', to: 'posts#post_comments', as: 'post_comments'
  # put 'posts/:id/comments', to: 'posts#comments', as: 'create_comment'
  put 'users/:id/befriend', to: 'users#befriend', as: 'befriend'
  put 'users/:id/break_friendship', to: 'users#break_friendship', as: 'break_friendship'
  put 'users/:id/accept_friendship_request', to: 'users#accept_friendship_request', as: 'accept_friendship_request'
  put 'users/:id/cancel_friendship_request', to: 'users#cancel_friendship_request', as: 'cancel_friendship_request'
  # put 'posts/:id/comment', to: 'posts#comment', as: 'new_post_comment'
end