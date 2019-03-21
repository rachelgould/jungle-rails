class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true
end
