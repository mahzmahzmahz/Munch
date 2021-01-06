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

# location1 = Location.create(borough: "Queens", neighborhood: "Flushing")
# location2 = Location.create(borough: "Brooklyn", neighborhood: "Greenpoint")


response = Net::HTTP.get_response('https://developers.zomato.com/api/v2.1/search?count=4&lat=user_lat&lon=user_lon')
body = response.body
parsed = JSON.paese(body)


puts "######## SEEDED #########"







# # 1: save everything to variables (makes it easy to connect models, best for when you want to be intentional about your seeds)
# basil = Plant.create(name: "basil the herb", bought: 20200610, color: "green")
# sylwia = Person.create(name: "Sylwia", free_time: "none", age: 30)
# pp1 = PlantParenthood.create(plant_id: basil.id, person_id: sylwia.id, affection: 1_000_000, favorite?: true)

# # 2. Mass create -- in order to connect them later IN SEEDS (not through the app) you'll need to find their id
# ## a. by passing an array of hashes:







# Plant.create([
#     {name: "Corn Tree", bought: 20170203, color: "green"},
#     {name: "Prayer plant", bought: 20190815, color: "purple"},
#     {name: "Cactus", bought: 20200110, color: "ugly green"}
# ])
# ## b. by interating over an array of hashes:
# plants = [{name: "Elephant bush", bought: 20180908, color: "green"},
#     {name: "Photos", bought: 20170910, color: "green"},
#     {name: "Dragon tree", bought: 20170910, color: "green"},
#     {name: "Snake plant", bought: 20170910, color: "dark green"},
#     {name: "polka dot plant", bought: 20170915, color: "pink and green"},
#     {name: "Cactus", bought: 20200517, color: "green"}]

# plants.each{|hash| Plant.create(hash)}






# # 3. Use Faker and mass create
# ## step 1: write a method that creates a person
# def create_person
#     free = ["mornings", "evenings", "always", "afternoons", "weekends", "none"].sample

#     person = Person.create(
#         name: Faker::Movies::HitchhikersGuideToTheGalaxy.character,
#         free_time: free,
#         age: rand(11...70)
#     )
# end

# ## step 2: write a method that creates a joiner
# def create_joiners(person)
#     plants_number = rand(1..4)
#     plants_number.times do 
#         PlantParenthood.create(
#             plant_id: Plant.all.sample.id, 
#             person_id: person.id, 
#             affection: rand(101), 
#             favorite?: [true, false].sample
#         )
#     end
# end

# ## step 3: invoke creating joiners by passing in an instance of a person
# 10.times do     
#     create_joiners(create_person)
#     ##### ALTERNATIVE:
#     # person = create_person
#     # create_joiners(person)
# end

# indoor = Category.create(name: "indoors")

# Plant.update(category_id: indoor.id)


# puts "🔥 🔥 🔥 🔥 "



