Rails.application.routes.draw do

resources :sessions
resources :registrations
resources :password_resets
resources :passwords

delete 'logout' => 'sessions#destroy', as: :logout

post '/data/receive_data', to: 'data#receive_data'
post 'bets/save_burst_data'

# get 'bets/new'
resources :bets, only: [:new, :create]
post '/bets/save_burst_data', to: 'bets#save_burst_data'

get 'deposits/new'
get 'deposits/create'
resources :deposits, only: [:new, :create]

get 'withdraws/new'
resources :withdraws, only: [:new, :create]

resources :messages, only: [:index, :create]

get '/animations', to: 'animations#index'


root "main#index"

end