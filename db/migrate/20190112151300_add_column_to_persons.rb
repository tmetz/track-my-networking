class AddColumnToPersons < ActiveRecord::Migration
  def change
    add_column :persons, :user_id, :integer
  end
end
