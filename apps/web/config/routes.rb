resources :sessions, only: [:new, :create]
get '/sessions/:id', to: 'sessions#destroy', as: 'session'
post '/sessions/unauthenticated', to: 'sessions#unauthenticated'

resources :registrations, only: [:new, :create]
get '/dashboards', to: 'dashboards#index', as: 'dashboards'

root to: 'sessions#new'
