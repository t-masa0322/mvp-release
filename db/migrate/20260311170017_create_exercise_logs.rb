class CreateExerciseLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :exercise_type
      t.integer :duration_minutes
      t.text :memo
      t.integer :earned_points

      t.timestamps
    end
  end
end
