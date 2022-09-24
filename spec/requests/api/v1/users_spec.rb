require 'rails_helper' 

RSpec.describe 'User CRUD' do 
  describe 'User Create' do 
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
    expect(response.body).to have_key(:data)
    expect(response.body[:data][:type]).to eq 'users' 
    expect(response.body[:data][:id]).to eq created_user.id 
    expect(response.body[:data][:id][:attributes][:email]).to eq "whatever@example.com"
    expect(response.body[:data][:id][:attributes][:api_key]).to eq created_user.password_digest
  end
end