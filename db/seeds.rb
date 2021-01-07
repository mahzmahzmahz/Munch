require 'net/http'

User.destroy_all
Restaurant.destroy_all
Style.destroy_all
Location.destroy_all
# RestaurantStyle.destroy_all
# RestaurantLocation.destroy_all
UserRestaurant.destroy_all

User.reset_pk_sequence
Restaurant.reset_pk_sequence
Style.reset_pk_sequence
Location.reset_pk_sequence
#RestaurantStyle.reset_pk_sequence
#RestaurantLocation.reset_pk_sequence
UserRestaurant.reset_pk_sequence

# ########### different ways to write your seeds ############

alex = User.create(username: "Alex", password: "1234")
elvis = User.create(username: "Elvis", password: "0000")

rest1 = Restaurant.create(name: "Munchies", price_point: "$$$", description: "The best joint in town!", street_address: "Brooklyn")
rest2 = Restaurant.create(name: "Funkies", price_point: "$$", description: "The 2nd best joint in town!", street_address: "Queens")
rest3 = Restaurant.create(name: "Tim's", price_point: "$$", description: "The 3rd best joint in town!", street_address: "Queens")
rest4 = Restaurant.create(name: "Mike's", price_point: "$$", description: "The 4th best joint in town!", street_address: "Queens")

UserRestaurant.create(user_id: alex.id, restaurant_id: rest1.id, favorite?: true)

style1 = Style.create(cuisine: "Chinese")
style2 = Style.create(cuisine: "Italian")



puts "######## SEEDED #########"

 # if !UserRestaurant.find_by(restaurant_id: @restaurant.id) 
        #     UserRestaurant.create(user_id: @user.id, restaurant_id: @restaurant.id, favorite?: true) 
        # end




