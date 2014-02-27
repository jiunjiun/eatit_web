class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :restaurant, index: true
      t.integer :overall
      t.integer :delicious
      t.integer :service
      t.integer :queues
      t.integer :feel
      t.references :user, index: true
      t.string :comment

      t.timestamps
    end
  end
end
