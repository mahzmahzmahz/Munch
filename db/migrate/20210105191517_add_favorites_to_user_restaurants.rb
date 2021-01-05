class AddFavoritesToUserRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :user_restaurants, :favorite?, :boolean
  end
end
