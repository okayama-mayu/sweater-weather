class User < ApplicationRecord
  validates_presence_of :email 

  has_secure_password

  def api_key
    password_digest
  end
end