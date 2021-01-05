class User < ActiveRecord::Base
# add associatons!
    has_many :user_restaurants
    has_many :restaurants, through: :user_restaurants

    attr_accessor :favorites 
    @favorites = []



    def add_restaurant_to_favorites(restaurant)
        UserRestaurant.create(user_id: self.id, restaurant_id: restaurant.id)
    end

    # def delete_restaurant_from_favorites(restaurant)
    #     UserRestaurant.delete(user_id: self.id, restaurant_id: restaurant.id)
    # end



  

end
