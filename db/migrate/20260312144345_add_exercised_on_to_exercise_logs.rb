class AddExercisedOnToExerciseLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :exercise_logs, :exercised_on, :date
  end
end
