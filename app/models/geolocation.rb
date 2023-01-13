class Geolocation < ApplicationRecord
    validates :ip,  presence: true 
    serialize :location_data, Hash
    
end
