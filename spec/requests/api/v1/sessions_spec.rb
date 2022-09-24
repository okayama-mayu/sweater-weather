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
        "email": "whatever@example.com", 
        "password": "password" 
      })

      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)

      user = User.find_by!(email: session_params[:email])

      expect(response).to be_successful 
      expect(response).to have_http_status(200)

      expect(response.body).to include("whatever@example.com")
      expect(response.body).to include(user.password_digest)
      expect(user.email).to eq "whatever@example.com"
    end

    it 'returns an error if the password is incorrect' do 
      session_params = ({
        "email": "whatever@example.com", 
        "password": "hehe" 
      })

      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)

      expect(response).to have_http_status(401)

      expect(response.body).to include("Your credentials are invalid") 
    end

    it 'returns an error if email is missing' do 
      session_params = ({
        "email": "", 
        "password": "hehe" 
      })

      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)

      expect(response).to have_http_status(401)

      expect(response.body).to include("Your credentials are invalid") 
    end
  end
end