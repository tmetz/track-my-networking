class Interaction < ActiveRecord::Base
    #belongs_to :person
    has_one :person
    belongs_to :user

    def self.create_formatted_date(year, month, day)
        return_string = "#{month} #{day}, #{year}"
    end

    def year
        return self.date.split(", ").second
    end

    def month
        return self.date.split(" ").first
    end

    def day
        return self.date.split(" ").second.chop
    end
end