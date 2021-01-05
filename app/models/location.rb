class Location < ActiveRecord::Base
    has_many :restaurant_locations
    has_many :restaurants, through: :restaurant_locations

    def get_lon_and_lat
    end
    



end
