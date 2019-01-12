class RemoveColumnFromPersons < ActiveRecord::Migration
  def up
    remove_column :persons, :user_id
  end

  def down
    add_column :persons, :user_id, :integer
  end
  
end
