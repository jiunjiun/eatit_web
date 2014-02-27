class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :category
      t.string :name
      t.string :address
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
