class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 30}, uniqueness: true

    validates :email, presence: true, length: { maximum: 255}, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true, length: { minimum: 6 }
    before_validation { email.downcase! }
    has_secure_password

    #association
    has_many :recettes
end
