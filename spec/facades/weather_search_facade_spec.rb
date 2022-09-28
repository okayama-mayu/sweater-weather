require 'rails_helper' 

RSpec.describe 'WeatherSearchFacade' do 
  it 'returns a Forecast object', :vcr do 
    forecast = WeatherSearchFacade.weather_search('denver, co')

    expect(forecast).to be_a Forecast
  end

  it 'returns a Roadtrip object', :vcr do 
    roadtrip = WeatherSearchFacade.road_trip_search('denver, co', 'estes park, co')
    
    expect(roadtrip).to be_a Roadtrip 
  end

  it 'returns a Book object', :vcr do 
    books = WeatherSearchFacade.book_search('denver, co', 8)

    expect(books).to be_a Book 
  end
end