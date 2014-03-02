class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :restaurant, index: true
      t.references :user, index: true
      t.references :task, index: true
      t.string :name
      t.string :size
      t.string :content_type

      t.timestamps
    end
  end
end
