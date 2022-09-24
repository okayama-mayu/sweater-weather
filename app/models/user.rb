class User < ApplicationRecord
  validates_presence_of :email
  validates :email, uniqueness: true 

  has_secure_password

  def api_key
    password_digest
  end
end