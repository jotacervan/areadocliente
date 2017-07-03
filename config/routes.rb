Rails.application.routes.draw do

  apipie

  root 'home#index'
  
  resources :users
  resources :customers
  resources :cores
  resources :stages
  resources :hops

  get 'login' => 'home#login', as: :login
  post 'signin' => 'home#signin', as: :signin
  get 'sign_out' => 'home#sign_out', as: :sign_out
  get 'profile' => 'home#profile', as: :profile
  post 'profile_user_update' => 'home#profile_user_update', as: :profile_user_update
  post 'profile_pic_update' => 'home#profile_pic_update', as: :profile_pic_update
  post 'profile_password_update' => 'home#profile_password_update', as: :profile_password_update
  get 'redirect_notification/:id' => 'home#redirect_notification', as: :redirect_notification
  get 'admin_approve/:id' => 'hops#admin_approve', as: :admin_approve
  
  # CLIENT ROUTES
  get 'client_dashboard' => 'home#client', as: :client_dashboard
  get 'client_projects/:id' => 'home#client_projects', as: :client_projects
  get 'approve/:id' => 'home#approve', as: :approve
  post 'hop_solicitation' => 'hops#solicitation', as: :hop_solicitation
  # CLIENT ROUTES
  
  # COMMENT ROUTES
  post 'new_comment_path' => 'home#new_comment', as: :new_comment
  # COMMENT ROUTES

  namespace :webservices do

    post 'hops/new'
    post 'hops/edit'
    get 'hops/show'
    get 'hops/show_all'
    get 'hops/priority'

  end
  

end
