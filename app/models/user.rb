class User < ApplicationRecord
  validates :name, presence: true
  validates :password_digest, presence: true
  validates_uniqueness_of :name

  has_secure_password
end
