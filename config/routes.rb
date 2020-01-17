Rails.application.routes.draw do
  resources :games
  resources :users, only:[:create, :update, :index]
  get "profile", to: "users#profile"
  post "login", to: "authentication#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
