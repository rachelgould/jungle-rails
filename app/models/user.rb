class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  validates_length_of :password, :minimum => 8
  
  def self.authenticate_with_credentials(email, password)
    User.find_by(email: email).try(:authenticate, password) || nil
  end
end
