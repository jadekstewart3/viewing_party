class User < ApplicationRecord

  validates_presence_of :name,
                        :email,
                        :password_digest
  has_secure_password

  validates :email, uniqueness: true

  has_many :party_users
  has_many :parties, through: :party_users
end
