Rails.application.routes.draw do
  
  # get 'welcome/index'
  devise_for :users
  root 'static_pages#home'
  get'help' => 'static_pages#help'
  get'about' =>'static_pages#about'
  get'contact' =>'static_pages#contact'
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  
end
