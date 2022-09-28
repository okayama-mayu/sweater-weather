require 'rails_helper' 

RSpec.describe User, type: :model do 
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
  it { should have_secure_token }

  # it 'returns the api_key of a User' do 
  #   user = User.create!(email: "whatever@example.com", "password": "password", "password_confirmation": "password")

  #   expect(user.api_key).to eq user.password_digest
  # end
end