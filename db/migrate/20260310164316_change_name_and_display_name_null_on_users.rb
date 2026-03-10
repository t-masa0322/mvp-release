class ChangeNameAndDisplayNameNullOnUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :name, true
    change_column_null :users, :display_name, true
  end
end
