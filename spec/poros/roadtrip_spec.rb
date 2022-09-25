require 'rails_helper' 

RSpec.describe Roadtrip do 
  it 'exists and has origin, destination, travel time, temperature, and weather conditions', :vcr do 
    origin = 'Houston, TX'
    destination = 'New Orleans, LA'

    weather_response = file_fixture('new_orleans_forecast_data.txt').read
    weather_data = JSON.parse(weather_response, symbolize_names: true)

    time_data = LocationService.search_directions(origin, destination)
    time_lapsed = time_data[:route][:time]

    roadtrip = Roadtrip.new(origin, destination, weather_data, time_lapsed)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.id).to eq nil 
    expect(roadtrip.start_city).to eq origin 
    expect(roadtrip.end_city).to eq destination
    expect(roadtrip.travel_time).to eq '05 hours 21 minutes 26 seconds'
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta[:temperature]).to eq 82.81
  end
end