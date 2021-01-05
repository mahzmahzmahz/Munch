class AddLonAndLatAndAddressToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :longitude, :float 
    add_column :locations, :latitude, :float 
    add_column :locations, :address, :string
  end
end
