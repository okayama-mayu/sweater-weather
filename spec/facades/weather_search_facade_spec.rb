require 'rails_helper' 

RSpec.describe 'WeatherSearchFacade' do 
  it 'returns a Location object', :vcr do 
    location = WeatherSearchFacade.weather_search('denver, co')

    expect(location).to be_a Location
  end
end