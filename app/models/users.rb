class User < ActiveRecord::Base
    has_secure_password
    has_many :interactions
    has_many :persons, through: :interactions

    # def slug
    #     new_name = self.name.downcase
    #     new_name.gsub!(/[!@%&"]/,'')
    #     new_name.gsub!(/\s/,'-')
    # end
    
    # def self.find_by_slug(slug)
    #     self.all.each do |user|
    #         if user.slug == slug
    #             return user
    #         end
    #     end
    #     return nil
    # end
end