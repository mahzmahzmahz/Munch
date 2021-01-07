require 'pry'
class User < ActiveRecord::Base
# add associatons!
    has_many :user_restaurants
    has_many :restaurants, through: :user_restaurants

    def add_restaurant_to_history(restaurant)
        UserRestaurant.create(user_id: self.id, restaurant_id: restaurant.id)
    end

    def remove_restaurant_from_history(restaurant)
        rest = UserRestaurant.where(user_id: self.id, restaurant_id: restaurant)
        rest.destroy_all
    end

    def remove_profile
        self.destroy
    end

end
