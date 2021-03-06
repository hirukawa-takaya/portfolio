Rails.application.routes.draw do
  
  root      'home#top'
  
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  
  get       '/login',      to: 'sessions#new'
  post      '/login',      to: 'sessions#create'
  delete    '/logout',     to: "sessions#destroy"
  
  resources :topics do
    resources :comments, only: [:create, :destroy]
  end
  get       'topic_password/:id', to: 'topics#topic_password'
  post      'topic_password/:id', to: 'topics#authenticate'
  delete    'topics/:id/destroy', to: 'topics#destroy'
  get       'topics/index'     ,  to: 'topics#search'
  post      'topics/send_mail/:id',   to: 'topics#send_mail'
  
  post      '/likes',      to: 'likes#create'
  delete    '/likes',      to: 'likes#destroy'
  
end
