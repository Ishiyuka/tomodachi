class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum: 20 }
    validates :email, presence: true, length: { maximum: 200 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, length: { minimum: 10 }  
    has_many :messages                
  end