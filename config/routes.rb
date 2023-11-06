Rails.application.routes.draw do

resources :sessions
resources :registrations
resources :password_resets
resources :passwords

delete 'logout' => 'sessions#destroy', as: :logout

post '/data/receive_data', to: 'data#receive_data'
post 'bets/save_burst_data'

# get 'bets/new'
resources :bets

get 'bet_placed', to: 'bets#bet_placed' # for all users bets settled=false
post '/bets/save_burst_data', to: 'bets#save_burst_data'
get '/bet_history', to: 'bets#bet_history' #for current_user all bets



  # resources :bets do
  #   collection do
  #     get :get_latest_betid
  #   end
  # end
  
post '/bets/update_burst_value', to: 'bets#update_burst_value'


get 'deposits/new'
get 'deposits/create'
resources :deposits, only: [:new, :create]

get 'withdraws/new'
resources :withdraws, only: [:new, :create]

resources :messages, only: [:index, :create]

get '/animations', to: 'animations#index'


root "main#index"

end