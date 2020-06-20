Rails.application.routes.draw do
  get  'topic_passwords', to: 'topic_passwords#new'
  post 'topic_passwords', to: 'topic_passwords#create'

  root 'home#top'
  get '/index', to:'home#index'
  
  resources :users
  
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: "sessions#destroy"
  
  resources :topics
  
  get 'likes/index'
  post '/likes', to: 'likes#create'
  delete '/likes', to: 'likes#destroy'
  
end
