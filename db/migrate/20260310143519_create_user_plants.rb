class CreateUserPlants < ActiveRecord::Migration[7.1]
  def change
    create_table :user_plants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :accumulated_points, null: false, default: 0
      t.datetime :selected_at, null: false
      t.datetime :archived_at

      t.timestamps
    end
  end
end
