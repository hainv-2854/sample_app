Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "home", to: "static_pages#home"
    get "help", to: "static_pages#help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(show new create)
  end
end
