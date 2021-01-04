class CreateRestaurantStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_styles do |t|
      t.integer :restaurant_id
      t.integer :style_id
      t.timestamps
    end
  end
end
