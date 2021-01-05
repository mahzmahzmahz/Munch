class RemoveColumnsFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :borough
    remove_column :locations, :neighborhood
  end
end
