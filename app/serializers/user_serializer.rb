class UserSerializer
  include JSONAPI::Serializer 
  attributes :email, :password_digest 

  alias_attribute :api_key, :password_digest
end