class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  validates_length_of :password, :minimum => 8
  before_save :downcase_fields
  
  def self.authenticate_with_credentials(email, password)
    User.find_by(email: email.strip.downcase).try(:authenticate, password) || nil
  end

  def downcase_fields
    self.email.downcase!
  end
end
