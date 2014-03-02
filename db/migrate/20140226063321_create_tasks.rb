class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string     :status , default: 'N', limitcrea: 1
      t.references :user, index: true
      t.references :restaurant, index: true

      t.timestamps
    end
  end
end
