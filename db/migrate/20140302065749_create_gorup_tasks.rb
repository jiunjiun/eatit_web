class CreateGorupTasks < ActiveRecord::Migration
  def change
    create_table :gorup_tasks do |t|
      t.references :task, index: true
      t.references :user, index: true
      t.string :invite_status

      t.timestamps
    end
  end
end
