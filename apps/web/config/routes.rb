# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

resources :sessions, only: [:new, :create, :destroy]
resources :registrations, only: [:new, :create]
root to: 'sessions#new'
