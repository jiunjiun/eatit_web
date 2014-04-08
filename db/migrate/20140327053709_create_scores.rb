class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user,       index: true
      t.references :task,       index: true
      t.references :restaurant, index: true
      t.integer    :overall,    limit: 1   , default: 0
      t.integer    :delicious,  limit: 1   , default: 0
      t.integer    :service,    limit: 1   , default: 0
      t.integer    :queues,     limit: 1   , default: 0
      t.integer    :feel,       limit: 1   , default: 0
      t.string     :comment,    limit: 50

      t.timestamps
    end
  end
end
