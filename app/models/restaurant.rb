class Restaurant < ActiveRecord::Base
  # add associatons!
  has_many :user_restaurants
  has_many :users, through: :user_restaurants

  has_many :restaurant_styles
  has_many :styles, through: :restaurant_styles

  has_many :restaurant_locations
  has_many :locations, through: :restaurant_locations

  

  
end
