class Style < ActiveRecord::Base
    has_many :restaurant_styles
    has_many :restaurants, through: :restaurant_styles
    
end
