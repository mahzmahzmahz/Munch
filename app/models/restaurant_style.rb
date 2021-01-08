class RestaurantStyle < ActiveRecord::Base
    belongs_to :style
    belongs_to :restaurant 
end
