Rails.application.routes.draw do

resources :sessions
resources :registrations
resources :password_resets
resources :passwords

resources :registrations, only: [:new, :create]

resources :users do
  resources :messages
end
get 'line_graph/data'
delete 'logout', to: 'sessions#destroy', as: :logout

post '/data/receive_data', to: 'data#receive_data'
post 'bets/save_burst_data'

resources :bets
get 'live_bets', to: 'bets#live_bets' # for all users bets settled=false
post '/bets/save_burst_data', to: 'bets#save_burst_data'
get '/bet_history', to: 'bets#bet_history' #for current_user all bets

post '/bets/update_burst_value', to: 'bets#update_burst_value'

get 'deposits/new'
get 'deposits/create'
resources :deposits, only: [:new, :create]

get 'withdraws/new'
resources :withdraws, only: [:new, :create]

resources :messages, only: [:index, :create]

get 'messages', to: 'messages#messages'
 get '/animation', to: 'animation#show' 


root "main#index"

end