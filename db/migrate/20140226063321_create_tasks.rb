class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string     :status,     default: 'N', limit: 1
      t.string     :url
      t.references :restaurant, index: true
      t.references :user,       index: true

      t.timestamps
    end
    add_index :tasks, [:restaurant_id, :user_id, :url]
  end
end
