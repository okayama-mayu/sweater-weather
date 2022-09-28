class User < ApplicationRecord
  validates_presence_of :email
  validates :email, uniqueness: true 

  has_secure_password
  has_secure_token

  def api_key
    password_digest
    # not secure; use has_secure_token for rails, SecureRandom (tool that creates unique key)
    # send screenshot to Juliet!
  end
end