require 'pry'
class User < ActiveRecord::Base
# add associatons!
    has_many :user_restaurants
    has_many :restaurants, through: :user_restaurants

    attr_accessor :favorites 
    @@favorites = []

    # def user_restaurants 
    #     self.restaurants.uniq 
    # end

    # def restaurant_name
    #     binding.pry
    #     user_restaurants.map{|rest| rest.name}
    # end


    # def add_restaurant_to_favorites(restaurant)
    #     #binding.pry
    #     favorite = UserRestaurant.create(user_id: self.id, restaurant_id: restaurant.id)
        
    #     @@favorite << favorite 
    # end

def add_restaurant_to_favorites(restaurant)
    UserRestaurant.create(user_id: self.id, restaurant_id: restaurant)
end

def remove_restaurant_from_favs(restaurant)
    rest = UserRestaurant.where(user_id: self.id, restaurant_id: restaurant)
    rest.destroy_all
end

def remove_profile
    self.destroy
end
  

end
