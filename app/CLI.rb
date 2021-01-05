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

  @@prompt = TTY::Prompt.new


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
      choice = @@prompt.select("Would you like to sign up or log in?", choices)
      if choice == 1
          CLI.login
      elsif choice == 2
          CLI.signup
      end
    end

    def self.login
       user = @@prompt.ask "Please enter Username"
       sleep (0.5)
       password = @@prompt.mask "Please enter Password"
       return_user = User.all.select{|user| user if user.username == user && user.password == password}
        puts "Welcome back #{user.capitalize}!"
    end



  end