class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string     :status,     default: 'N', limit: 1
      t.string     :name,       limit: 50
      t.string     :url
      t.string     :note,       limit: 100
      t.references :restaurant, index: true
      t.references :user,       index: true

      t.timestamps
    end
    add_index :tasks, [:url, :restaurant_id, :user_id]
  end
end
