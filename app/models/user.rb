require 'pry'
class User < ActiveRecord::Base
# add associatons!
    has_many :user_restaurants
    has_many :restaurants, through: :user_restaurants

    attr_accessor :favorites 
    @@favorites = []

    def user_restaurants 
        self.restaurants.uniq 
    end

    def restaurant_name
        binding.pry
        user_restaurants.map{|rest| rest.name}
    end


    def add_restaurant_to_favorites(restaurant)
        #binding.pry
        favorite = UserRestaurant.create(user_id: self.id, restaurant_id: restaurant.id)
        
        @@favorite << favorite 
    end

    # def delete_restaurant_from_favorites(restaurant)
    #     UserRestaurant.delete(user_id: self.id, restaurant_id: restaurant.id)
    # end



  

end
