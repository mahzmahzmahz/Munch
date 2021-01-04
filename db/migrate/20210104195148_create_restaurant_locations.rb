class CreateRestaurantLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_locations do |t|
      t.integer :location_id
      t.integer :restaurant_id
      t.timestamps
    end
  end
end
