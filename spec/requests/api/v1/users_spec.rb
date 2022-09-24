require 'rails_helper' 

RSpec.describe 'User CRUD' do 
  describe 'User Create' do 
    it 'creates a User and returns a serialized response with email and api_key' do 
      user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)

      created_user = User.last 

      expect(response).to be_successful 
      expect(response).to have_http_status(201)
      
      expect(response.body).to include("whatever@example.com")
      expect(response.body).to include(created_user.password_digest)
      expect(created_user.email).to eq user_params[:email]
    end
  end
end