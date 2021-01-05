class UserRestaurant < ActiveRecord::Base
  # add associatons!
    belongs_to :restaurant 
    belongs_to :user

end
