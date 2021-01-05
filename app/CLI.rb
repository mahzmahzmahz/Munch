# class YourAppName
#   # here will be your CLI!
#   # it is not an AR class so you need to add attr

#   def run
#     welcome
#     # login_or_signup
#     # wanna_see_favs?
#     # get_joke(what_subject)
#   end


#   private

#   def welcome
#     system 'clear'


  
# end
require "tty-prompt"
require "tty-font"
require "pry"


class CLI

  attr_accessor :user, :restaurant, :user_restaurant, :restaurant_location, :location, :style, :restaurant_style

  @prompt = TTY::Prompt.new


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
        password = @prompt.mask("What is your Password?")
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
        # pizza = @@prompt.decorate(‘🍕 ‘)
        password = @prompt.mask ("Please create a Password")  
        User.create(username: username, password: password)
    end

    def self.main_menu
        system 'clear'
        @user.reload 
        sleep(0.5)
        @prompt.select("What Brings You Here?") do |menu|
            menu.choice "Restaurant History", -> {CLI.rest_history}
            menu.choice "View my favorite restaurants", -> {CLI.fav_restaurant}
            menu.choice "Find a new spot", -> {CLI.new_spot}
            menu.choice "Exit", -> {CLI.exit_helper}
        end
        
    end

    def self.exit_helper
        puts "Cya l8rr, hope you don't starve."
    end

    def self.rest_history
        restaurants = UserRestaurant.select{|user_rest| user_rest.user_id == @user.id}
        restaurants.map{|rest| puts rest.restaurant.name}
        sleep(1)
        choice = @prompt.select("Main menu?") do |menu|
            menu.choice "Yes"
            menu.choice "No"

            if choice == "Yes"
                CLI.main_menu
            else
                system 'clear'
                CLI.rest_history
            end
            

            
        end
    
        
    end

    # def self.fav_restaurant
    #     restaurants = UserRestaurant.select{|user_rest| user_rest.user_id == @user.id && favorite? == true}
    #     restaurants.map{|rest| puts rest.restaurant.name}
    # end




end


