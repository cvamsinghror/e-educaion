Rails.application.routes.draw do
  get 'notifications/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'authentication#signup'

  resources :users 
  resources :follows, only: [:create, :destroy]
  get 'users/:id/following', to: 'follows#index'

  resources :posts do
    resources :comments, only: [:create]
  end

  resources :notifications, only: [:index]


  resources :course_categories, only: [:index]
  resources :courses, only: [:index, :create]
  resources :enrollments, only: [:create, :index]



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  
end
