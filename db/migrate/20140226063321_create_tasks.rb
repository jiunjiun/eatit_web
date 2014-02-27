class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :status
      t.references :user, index: true
      t.references :restaurant, index: true

      t.timestamps
    end
  end
end
