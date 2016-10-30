class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #This is a Ruby Constant!
    before_save { email.downcase! } #Modifying attribute directly with '!' at the end of method
    validates(:name, presence: true, length: { maximum: 50 }) #Presence ensures non blank or empty
    validates(:email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
    validates(:password, presence: true, length: { minimum: 6 }) 
    has_secure_password
end
