class RestaurantStyle < ActiveRecord::Base
    belongs_to :restaurant_style
    belongs_to :restaurant 
end
