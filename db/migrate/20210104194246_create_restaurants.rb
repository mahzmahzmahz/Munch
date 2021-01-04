class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :price_point
      t.string :description
      t.string :street_address
      t.timestamps
    end
  end
end

