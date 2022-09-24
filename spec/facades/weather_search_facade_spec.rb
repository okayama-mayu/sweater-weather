require 'rails_helper' 

RSpec.describe 'WeatherSearchFacade' do 
  it 'returns a Forecast object', :vcr do 
    forecast = WeatherSearchFacade.weather_search('denver, co')

    expect(forecast).to be_a Forecast
  end
end