Rails.application.routes.draw do
  
  root      'home#top'
  get       '/index',      to:'home#index'
  
  resources :users
  
  get       '/login',      to: 'sessions#new'
  post      '/login',      to: 'sessions#create'
  delete    '/logout',     to: "sessions#destroy"
  
  get       'topic_password/:id', to: 'topics#topic_password'
  post      'topic_password/:id', to: 'topics#authenticate'
  delete    'topics/:id/destroy', to: 'topics#destroy'
  resources :topics
  
  get       'likes/index'
  post      '/likes',      to: 'likes#create'
  delete    '/likes',      to: 'likes#destroy'
  
end
