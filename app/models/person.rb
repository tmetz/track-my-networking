class Person < ActiveRecord::Base
    has_many :interactions
    has_many :persons, through: :interactions
end
