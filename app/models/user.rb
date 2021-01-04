class User < ActiveRecord::Base
# add associatons!
    has_many :user_restaurants
    has_many :restaurants, through: :user_restaurants

end
