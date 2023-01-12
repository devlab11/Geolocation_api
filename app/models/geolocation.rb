class Geolocation < ApplicationRecord
    validates :ip,  presence: true 
    serialize :preferences, Hash
    
end
