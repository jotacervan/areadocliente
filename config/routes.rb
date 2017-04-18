Rails.application.routes.draw do
  
  root 'home#index'

  resources :users

  get 'login' => 'home#login', as: :login
  post 'signin' => 'home#signin', as: :signin
  get 'profile' => 'home#profile', as: :profile
  post 'profile_user_update' => 'home#profile_user_update', as: :profile_user_update
  post 'profile_pic_update' => 'home#profile_pic_update', as: :profile_pic_update
  post 'profile_password_update' => 'home#profile_password_update', as: :profile_password_update

end
