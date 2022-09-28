class UserSerializer
  include JSONAPI::Serializer 
  attributes :email, :token 
end