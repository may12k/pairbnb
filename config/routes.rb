Rails.application.routes.draw do
  get 'welcome/index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]

    
  end
  resources :users do
    resources :listings
  end

  resources :listings do 
    resources :reservations
  end

  root 'static_pages#index'
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get '/braintree/new' => "braintree#new"
  post '/braintree/checkout' =>'braintree/checkout'
  get 'welcome/index' => "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
