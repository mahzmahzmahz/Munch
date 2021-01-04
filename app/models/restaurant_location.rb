class RestaurantLocation < ActiveRecord::Base
    belongs_to :restaurant 
    belongs_to :location 
end
