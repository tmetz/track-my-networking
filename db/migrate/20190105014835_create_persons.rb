class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.string :email
      t.string :name
      t.string :linkedin
      t.string :phone
      t.string :company_name
      t.string :meeting_place
      t.string :subjects
      t.timestamps null: false
    end
  end
end
