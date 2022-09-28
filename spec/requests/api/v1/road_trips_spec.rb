require 'rails_helper' 

RSpec.describe 'Roadtrip CRUD' do 
  before :each do 
    user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
  end

  describe 'create Roadtrip' do 
    it 'creates a Roadtrip given origin, destination, and api_key', :vcr do 
      api_key = User.find_by!(email: "whatever@example.com").token

      body = ({
        "origin": "Denver, CO", 
        "destination": "Pueblo, CO", 
        "api_key": api_key
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(response.body).to include('roadtrip')
      expect(response.body).to include('Denver, CO')
      expect(response.body).to include('Pueblo, CO')
      expect(response.body).to include('travel_time')
      expect(response.body).to include('weather_at_eta')
      expect(response.body).to include('temperature')
      expect(response.body).to include('conditions')
    end

    it 'creates a Roadtrip for trips lasting over 40 hours', :vcr do 
      api_key = User.find_by!(email: "whatever@example.com").token

      body = ({
        "origin": "New York, NY", 
        "destination": "Los Angeles, CA", 
        "api_key": api_key
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(response.body).to include('roadtrip')
      expect(response.body).to include('New York, NY')
      expect(response.body).to include('Los Angeles, CA')
      expect(response.body).to include('travel_time')
      expect(response.body).to include('40 hours 16 minutes')
      expect(response.body).to include('weather_at_eta')
      expect(response.body).to include('temperature')
      expect(response.body).to include('conditions')
    end

    it 'creates a Roadtrip for trips lasting over 2 days or 48 hours', :vcr do 
      api_key = User.find_by!(email: "whatever@example.com").token

      body = ({
        "origin": "New York, NY", 
        "destination": "Panama City, Panama", 
        "api_key": api_key
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(response.body).to include('roadtrip')
      expect(response.body).to include('New York, NY')
      expect(response.body).to include('Panama City, Panama')
      expect(response.body).to include('travel_time')
      expect(response.body).to include('80 hours 04 minutes')
      expect(response.body).to include('weather_at_eta')
      expect(response.body).to include('temperature')
      expect(response.body).to include('conditions')
    end

    it 'returns an empty weather block and travel time of impossible if travelling from NYC to London', :vcr do 
      api_key = User.find_by!(email: "whatever@example.com").token

      body = ({
        "origin": "New York, NY", 
        "destination": "London, UK", 
        "api_key": api_key
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(response.body).to include('roadtrip')
      expect(response.body).to include('New York, NY')
      expect(response.body).to include('London, UK')
      expect(response.body).to include('travel_time')
      expect(response.body).to include('impossible')
      expect(response.body).to include('weather_at_eta')
      expect(response.body).to include('{}')
    end

    it 'returns an error if no api key', :vcr do 
      body = ({
        "origin": "Denver, CO", 
        "destination": "Pueblo, CO"
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(body)
      
      expect(response).to have_http_status(401)
      expect(response.body).to include('API key must be submitted as part of the request')
    end
  end
end