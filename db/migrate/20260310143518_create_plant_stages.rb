class CreatePlantStages < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_stages do |t|
      t.references :plant, null: false, foreign_key: true
      t.string  :name, null: false
      t.integer :stage_order, null: false
      t.integer :required_points, null: false

      t.timestamps
    end

    add_index :plant_stages, [:plant_id, :stage_order], unique: true
  end
end
