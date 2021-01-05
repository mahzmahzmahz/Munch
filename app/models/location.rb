require 'geocoder'
class Location < ActiveRecord::Base
    has_many :restaurant_locations
    has_many :restaurants, through: :restaurant_locations

    # geocoded_by :address 
    # after_validation :geocode, :if => :address_changed?


    




end
