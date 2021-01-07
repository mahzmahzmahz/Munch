require "tty-prompt"
require "tty-font"
require "pry"
require 'geocoder'
#elvis can pull now

class CLI

  attr_accessor :user, :restaurant, :user_restaurant, :restaurant_location, :location, :style, :restaurant_style

  @prompt = TTY::Prompt.new

  $pizza = @prompt.decorate('🍕')

  def self.welcome
      system ('clear')
      font = TTY::Font.new(:"starwars")
      pastel = Pastel.new
      puts pastel.blue(font.write("Munch"))

  end

  def self.login_menu
      CLI.welcome
      choices = { "Log In" => 1,
          "Sign Up" => 2
      }
      choice = @prompt.select("Would you like to sign up or log in?", choices)
      if choice == 1
          CLI.login
      elsif choice == 2
          CLI.signup
      end
    end

    def self.login
        username = @prompt.ask("What is your Username?")
        password = @prompt.mask("What is your Password?", mask: $pizza)
        if User.find_by(username: username, password: password)
            @user = User.find_by(username: username, password: password)
            @user
            CLI.main_menu
        else 
            puts "Unknown User or Password"
            sleep(1)
            system ('clear')
            CLI.login_menu
        end
    end

    def self.signup
        username = @prompt.ask ("Please create a Username")
        while User.find_by(username: username) 
            puts ("Sorry Username is Taken")
            username = @prompt.ask ("Please create a Username")
        end
        password = @prompt.mask("Please create a Password", mask: $pizza)  
        User.create(username: username, password: password)
        system 'clear'
        puts "Welcome to the party, pal! Let's make sure that works - "
        sleep(2)
        CLI.login_menu
    end

    def self.main_menu
        system 'clear'
        @user.reload 
        sleep(0.5)
        @prompt.select("What Brings You Here?") do |menu|
            menu.choice "Restaurant History", -> {CLI.rest_history}
            menu.choice "View my favorite restaurants", -> {CLI.fav_restaurant}
            menu.choice "Find a new spot", -> {CLI.new_spot}
            menu.choice "Delete Profile", -> {CLI.bye_bye}
            menu.choice "Exit", -> {CLI.exit_helper}
        end
        
    end

    def self.exit_helper
        system 'clear'
        options = ["Cya l8rr, hope you don't starve.", "Ok bye, btw you are rocking that outfit today!", "Word. Catch you on the flip!"]
        puts options.shuffle.first
    end

    def self.rest_history
        #binding.pry
        restaurants = UserRestaurant.select{|user_rest| user_rest.user_id == @user.id}

        if restaurants == []
            sleep(0.5)
            puts "Looks like you haven't been out yet!"
        else
           puts restaurants.map{|rest| rest.restaurant.name}
        end

        sleep(1)
        @prompt.select("Would you like to return to the main Menu, clear your list, or are we all good here?") do |menu|
            menu.choice "Main Menu", -> {CLI.main_menu}
            menu.choice "Clear My History", -> {CLI.clear_history}
            menu.choice "I'm all good, thx!", -> {CLI.exit_helper}
        end
    
        
    end

    def self.clear_history
        system 'clear'
        ask = @prompt.yes?("Are you sure you want to get rid of all your restaurants?")
        if ask == true
            rest = @user.restaurants
            rest.destroy_all
            system 'clear'
            puts "Cool, not like we worked hard putting that together for you or anything..."
            sleep (4)
            CLI.main_menu
        else
            system 'clear'
            CLI.rest_history
        end
        #binding.pry
    end

    

    def self.bye_bye
        @user.remove_profile
        system 'clear'
        puts "Whatever, you'll be back..."
    end



    def self.new_spot
        random_phrases = ["Oh wow, my cousin lives there! Do you know a large man named Tommy?", "Oh jeez, the subway there is a mess huh?", "I lived there when I moved here! It's the best, right?"]
        #cuisines = ["Italian", "American", "Chinese", "Indian", "Fast-food", "Pizza", "Mexican", "Other"]
        boroughs = ["Staten Island", "Queens", "Brooklyn","The Bronx", "Manhattan", "I don't live in NYC..."]
        #price_options = [1, 2, "$$$"]
        cuisine_choice = @prompt.ask("What are you craving? Ex: Italian, Chinese, Mexican etc.")
            if cuisine_choice.nil?
                cuisine_choice = "Cafe"
            end
        system 'clear'
        puts "Nice, we love #{cuisine_choice}!"
        sleep(0.5)
        user_location = @prompt.select("Next up, where are you tryin' to eat in the 5 boroughs?", boroughs, min: 1)
            if user_location == "I don't live in NYC..."
                system 'clear'
                puts "You're not from NYC?! Hmmm, I don't think we can help you today!"
                sleep(3)
                CLI.main_menu
            else
        system 'clear'
        puts random_phrases.shuffle.first
        user_price_point = @prompt.ask("And finally, how much money do you want to spend on a scale of 1-4?"){ |q| q.in("1-4") }
                if user_price_point == "1"
                    puts "BIG SPENDER OVA HERE! Good for you!" 
                elsif user_price_point == "2"
                    puts "Ok, out for a date I bet 😘"
                elsif user_price_point == "3" 
                    puts "Love it, let's find something for ya - "
                else 
                    puts "Ballin' on a budget. Respect!"   
                end
            end
        sleep(3)
        #binding.pry
        @restaurant = CLI.api_restaurants(user_location, user_price_point, cuisine_choice)
        
        # if !UserRestaurant.find_by(restaurant_id: @restaurant.id) 
        #     UserRestaurant.create(user_id: @user.id, restaurant_id: @restaurant.id, favorite?: true) 
        # end
        
     end

    def self.api_restaurants(location, price_point, cuisine)
        #binding.pry

        ########    GEOCODER LOCATION FINDER     ###########
        lat_lon = CLI.geocode(location)
        user_lat = lat_lon[:lat]
        user_lon = lat_lon[:lon]

        #########  API DATA FINDER      ###########
        response =  RestClient.get "https://developers.zomato.com/api/v2.1/search?count=20&lat=#{user_lat}&lon=#{user_lon}&radius=3500&sort=real_distance",
            {content_type: :json, accept: :json, "user-key": "285cd5fbd4736f1cfef4d09c58ef09b4"}
        parsed = JSON.parse(response)
        

        #########  PRICE POINT MATCHER    #######
        price = price_point.to_i
        rest_level_one = parsed["restaurants"]
        rest_level_two = rest_level_one.select{|rest| rest["restaurant"]["name"] if rest["restaurant"]["price_range"] == price}
        sugg = rest_level_two.map{|rest| rest["restaurant"]["name"]}
       
        
        
        ########   CUISINE MATCHER   ########
        #binding.pry
        rest_level_one = parsed["restaurants"]
        rest_level_three = rest_level_one.find_all{|rest| rest["restaurant"]["name"] if rest["restaurant"]["cuisines"].include? cuisine}
        matched_food = rest_level_three.map{|rest| rest["restaurant"]["name"]}
#binding.pry
        results = sugg & matched_food
        real_results = results.shuffle.first
            if real_results == nil
                 puts "Oh dear, we're having trouble with this one, lets try again!"
                 CLI.new_spot
            end

        ######### ADDRESS ######
        address = rest_level_two.find{|rest| rest["restaurant"]["location"]["address"] if rest["restaurant"]["name"] == real_results}
        address = address["restaurant"]["location"]["address"]


        ############ RETURN MESSAGE WITH SUGGESTION (AND USERRESTAURANT CREATOR)   ###########
        puts "Have you ever been to #{real_results}?" 
        puts "It's located at #{address} - " 
        puts "We think you should try it!"
        sleep(1)


            ############ CREATE AND STORE RESTAURANT  ##############
            binding.pry 
        restaurant = Restaurant.create(name: "#{real_results}" , price_point: "#{price_point}", description: "#{cuisine}", street_address: "#{address}")
        @user.add_restaurant_to_history(restaurant)



             ############ MENU OPTIONS HELPER ###########
ask = @prompt.yes?("We've added #{real_results} to you list! Would you like to go again?")
            if ask == true
                system 'clear'
                CLI.new_spot
            else
                puts "Glad we could help!"
                sleep(2)
                CLI.main_menu
            end
    end

    def self.geocode(location)
        place = Geocoder.search(location).first.coordinates
        latitude = place[0]
        longitude = place[1]
        return {lat: latitude, lon: longitude} 
    end
    
    # def self.price(price_point)
    #     lat_lon = CLI.geocode(location)
    #     user_lat = lat_lon[:lat]
    #     user_lon = lat_lon[:lon]
    #     response =  RestClient.get "https://developers.zomato.com/api/v2.1/search?count=50&lat=#{user_lat}&lon=#{user_lon}&radius=3500&sort=real_distance",
    #         {content_type: :json, accept: :json, "user-key": "285cd5fbd4736f1cfef4d09c58ef09b4"}
    #     parsed = JSON.parse(response)
    #     price = price_point.to_i
    #     rest_level_one = parsed["restaurants"]
    #     rest_level_two = rest_level_one.select{|rest| rest["restaurant"]["name"] if rest["restaurant"]["price_range"] == price}
    #     sugg = rest_level_two.map{|rest| rest["restaurant"]["name"]}
    #     suggestion = sugg.shuffle.first
    #     suggestion
    # end
    
    # def self.foods(cuisine)
        
    # end




end
# price = price_point.to_i
# rest_level_one = parsed["restaurants"]
# rest_level_two = rest_level_one.select{|rest| rest["restaurant"]["name"] if rest["restaurant"]["price_range"] == price}
# rec = rest_level_two.map{|rest| rest["restaurant"]["name"]}
# rec.shuffle.first
