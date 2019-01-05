class User < ActiveRecord::Base
    has_secure_password
    has_many :interactions
    has_many :persons, through: :interactions
end