class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      # t.string  :category
      t.string  :name
      t.string  :area
      t.string  :address
      t.string  :telephone
      t.integer :count,    default: 0
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end
