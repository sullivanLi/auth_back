Rails.application.routes.draw do
  namespace :api do
    post '/users/create', to: 'users#create'
    post '/users/login', to: 'users#login'
    post '/users/logout', to: 'users#logout'

    get '/greetings', to: 'greetings#index'
  end
end
