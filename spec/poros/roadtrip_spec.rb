require 'rails_helper' 

RSpec.describe Roadtrip do 
  it 'exists and has origin, destination, travel time, temperature, and weather conditions' do 
    origin = 'Houston, TX'
    destination = 'New Orleans, LA'

    weather_response = file_fixture('new_orleans_forecast_data.txt').read
    weather_data = JSON.parse(weather_response, symbolize_names: true)

    time_data = LocationService.search_directions(origin, destination)
    time_lapsed = time_data[:route][:time]

    binding.pry 
    roadtrip = Roadtrip.new(origin, destination, weather_data)
  end
end