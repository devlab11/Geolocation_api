Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get    'geolocations',      to: 'geolocations#index'
      post   'geolocations',      constraints: lambda { |req|
                                                 req.format == :json
                                               }, to: 'geolocations#create', defaults: { format: 'json' }
      get    'geolocations/:id',  to: 'geolocations#show'
      # put    'geolocations/:id'  , to: 'geolocations#update'
      delete 'geolocations/:id', to: 'geolocations#destroy'
      match  '*path', to: 'geolocations#routing_error', via: :all
    end
  end
end
