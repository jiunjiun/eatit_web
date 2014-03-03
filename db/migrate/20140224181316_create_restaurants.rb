class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string  :category
      t.string  :name
      t.string  :address
      t.string  :telephone
      t.integer :count,    defualt: 0
      t.float   :lat
      t.float   :long

      t.timestamps
    end
  end
end
