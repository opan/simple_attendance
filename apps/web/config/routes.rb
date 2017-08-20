resources :sessions, only: [:new, :create, :destroy]
post '/sessions/unauthenticated', to: 'sessions#unauthenticated'

resources :registrations, only: [:new, :create]
get '/dashboards', to: 'dashboards#index', as: 'dashboards'

root to: 'sessions#new'
