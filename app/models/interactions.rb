class Interaction < ActiveRecord::Base
    belongs_to :person
    belongs_to :user

    def self.create_formatted_date(year, month, day)
        return_string = "#{month} #{day}, #{year}"
    end
end