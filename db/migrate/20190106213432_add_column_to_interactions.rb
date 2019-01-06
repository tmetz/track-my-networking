class AddColumnToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :notes, :string
  end
end
