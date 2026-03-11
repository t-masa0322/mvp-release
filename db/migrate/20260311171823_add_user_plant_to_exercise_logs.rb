class AddUserPlantToExerciseLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercise_logs, :user_plant, null: true, foreign_key: true
  end
end
