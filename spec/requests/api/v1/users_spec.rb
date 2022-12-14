require 'rails_helper' 

RSpec.describe 'User CRUD' do 
  describe 'User Create/POST' do 
    it 'creates a User and returns a serialized response with email and api_key' do 
      user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      created_user = User.last 

      expect(response).to be_successful 
      expect(response).to have_http_status(201)

      expect(response.body).to include("whatever@example.com")
      expect(response.body).to include(created_user.token)
      expect(created_user.email).to eq user_params[:email]
    end

    it 'returns an error if passwords do not match' do 
      user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "hehe"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Password confirmation doesn't match Password")
    end

    it 'returns an error if email has already been taken' do 
      # create User 
      user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      
      # create User w same email 

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Email has already been taken")
    end

    it 'returns an error if field is missing' do 
      # create User 
      user_params = ({
        "email": "whatever@example.com",
        "password": "",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      
      # create User w same email 

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Password can't be blank")
    end
  end
end