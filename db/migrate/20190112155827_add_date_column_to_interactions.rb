class AddDateColumnToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :date, :string
  end
end
