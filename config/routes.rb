Rails.application.routes.draw do
  
  get 'clients/index'

  root 'home#index'

  resources :users
  resources :clients

  get 'login' => 'home#login', as: :login
  post 'signin' => 'home#signin', as: :signin
  get 'sign_out' => 'home#sign_out', as: :sign_out
  get 'profile' => 'home#profile', as: :profile
  post 'profile_user_update' => 'home#profile_user_update', as: :profile_user_update
  post 'profile_pic_update' => 'home#profile_pic_update', as: :profile_pic_update
  post 'profile_password_update' => 'home#profile_password_update', as: :profile_password_update

end
