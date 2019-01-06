class Interaction < ActiveRecord::Base
    belongs_to :person
    belongs_to :user
end