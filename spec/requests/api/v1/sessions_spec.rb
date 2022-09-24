require 'rails_helper' 

RSpec.describe 'Session CRUD' do 
  before :each do 
    user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
  end
  
  describe 'Session Create' do 
    it 'can create a Session and returns an email and api_key' do 
      session_params = ({
        "email": "whatever@eample.com", 
        "password": "password" 
      })

      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)

      user = User.find_by!(email: session_params[:email])

      expect(response).to be_successful 
      expect(response).to have_http_status(201)

      expect(response.body).to include("whatever@example.com")
      expect(response.body).to include(created_user.password_digest)
      expect(user.email).to eq "whatever@example.com"
    end
  end
end