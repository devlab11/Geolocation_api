Rails.application.routes.draw do
  get    'geolocations', to: 'geolocations#index'
  post   'geolocations', constraints: lambda { |req| req.format == :json }, to: 'geolocations#create',  defaults: { format: 'json' }
  get    'geolocations/:id',  to: 'geolocations#show' 
  #put    'geolocations/:id'  , to: 'geolocations#update'          
  delete 'geolocations/:id' , to: 'geolocations#destroy'

  match '*path', :to => 'application#routing_error', via: :all
end
