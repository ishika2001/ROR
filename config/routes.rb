Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'events/show'
  get 'events/edit'
  get 'events/destroy'
  get 'events/update'
  get 'events/new'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
   end

   
  root "home#index"
  get 'home', to: "home#index"
  resource "home"
  resources :tickets
  resources :organizers
  resources :attenders
  resources :users, only: [:index]

  resources :events do
    resources :comments
  end
  get "/show", to: "events#show"
  get "/edit", to: "events#edit"
  get "/destroy", to: "events#destroy"

  get "/show", to: "tickets#show"
  get "/edit", to: "tickets#edit"
  get "/destroy", to: "tickets#destroy"

  get "/show", to: "comments#show"

  get "/attenders/show", to: "attenders#show"
  get "/tickets/show", to: "tickets#show"
  get "/book", to: "tickets#book"
  get "/organizers/index", to: "organizers#index"
  get "/attenders/index", to: "attenders#index"
  get "download_pdf/:id", to: "tickets#download_pdf", as: 'download_pdf'

  namespace :api do
    namespace :v1 do
      resources :events, :users, :organizers, :attenders, :tickets, :home
      post "/login", to: "users#login"
      get "/logout", to: "users#logout"

      resources :events do
        resources :comments, :tickets
      end
    end
  end
end



 

