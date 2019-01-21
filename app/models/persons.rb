class Person < ActiveRecord::Base
    self.table_name = "persons" # otherwise ActiveRecord will look for "people" table
    belongs_to :interactions
    # has_many :interactions
    # has_many :users, through: :interactions
end
