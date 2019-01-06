class CreateInteractionsTable < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :user_id
      t.integer :person_id
    end
  end
end
